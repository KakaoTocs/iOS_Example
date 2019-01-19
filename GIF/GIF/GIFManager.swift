//
//  GIFManager.swift
//  GIF
//
//  Created by Jinu Kim on 08/01/2019.
//  Copyright © 2019 com.kakaotocs. All rights reserved.
//

import UIKit
import MobileCoreServices
import ImageIO
import AVFoundation

// https://github.com/matthewpalmer/Regift/blob/master/Regift/Regift.swift
public typealias TimePoint = CMTime

public enum GIFManagerError: String, Error {
    case DestinationNotFound = "The temp file destination could not be created or found"
    case SourceFormatInvalid = "The source file does not appear to be a valid format"
    case AddFrameToDestination = "An error occurred when adding a frame to the destination"
    case DestinationFinalize = "An error occurred when finlizing the destination"
}

private struct Group {
    let group = DispatchGroup()
    
    func enter() {
        group.enter()
    }
    
    func leave() {
        group.leave()
    }
    
    func wait() {
        let _ = group.wait(timeout: DispatchTime.distantFuture)
    }
}

public struct GIF {
    public static func create(sourceFileURL: URL, destinationFileURL: URL? = nil, frameCount: Int, delayTime: Float, loopCount: Int = 0, size: CGSize? = nil, completion: (_ result: URL?) -> Void) {
//        let gif = GIF
    }
    
    
    public static func create(sourceFileURL: URL, destinationFileURL: URL? = nil) {
        
    }
    
    private struct Constants {
        static let FileName = "gitImage.gif"
        static let TimeInterval: Int32 = 600
        static let Tolerance = 0.01
    }
    
    private var asset: AVAsset
    
    private let sourceFileURL: URL
    
    private var startTime: Float = 0
    
    private var duration: Float
    
    private var movieLength: Float
    
    private let frameCount: Int
    
    private let delayTime: Float
    
    private let loopCount: Int
    
    private var destinationFileURL: URL?
    
    fileprivate let size: CGSize?
    
    public init(sourceFileURL: URL, destinationFileURL: URL? = nil, frameCount: Int, delayTime: Float, loopCount: Int = 0, size: CGSize? = nil) {
        self.sourceFileURL = sourceFileURL
        self.asset = AVURLAsset(url: sourceFileURL, options: nil)
        self.movieLength = Float(asset.duration.value) / Float(asset.duration.timescale)
        self.duration = movieLength
        self.delayTime = delayTime
        self.loopCount = loopCount
        self.destinationFileURL = destinationFileURL
        self.frameCount = frameCount
        self.size = size
    }
    
    public func createGIF() -> URL? {
        let fileProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFLoopCount as String: NSNumber(value: Int32(loopCount) as Int32)], kCGImagePropertyGIFHasGlobalColorMap as String: NSValue(nonretainedObject: true)]
        
        let frameProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFDelayTime as String:delayTime]]
        
        let increment = Float(duration) / Float(frameCount)
        
        var timePoints: [TimePoint] = []
        
        for frameNumber in 0..<frameCount {
            let seconds: Float64 = Float64(startTime) + (Float64(increment) * Float64(frameCount))
            let time = CMTimeMakeWithSeconds(seconds, preferredTimescale: Constants.TimeInterval)
            
            timePoints.append(time)
        }
        
        do {
            return try create(timePoints, fileProperties: fileProperties as [String: AnyObject], frameProperties: frameProperties as [String: AnyObject], frameCount: frameCount, size: size)
        } catch {
            return nil
        }
    }
    
    public func createGIFForTimePoints(_ timePoints: [TimePoint], fileProperties: [String: AnyObject],  frameProperties: [String: AnyObject], frameCount: Int, size: CGSize? = nil) throws -> URL {
        guard asset.tracks(withMediaCharacteristic: .visual).count > 0 else {
            throw GIFManagerError.SourceFormatInvalid
        }
        
        var fileURL: URL?
        if self.destinationFileURL != nil {
            fileURL = self.destinationFileURL
        } else {
            let temporaryFile = (NSTemporaryDirectory() as NSString).appendingPathComponent(Constants.FileName)
            fileURL = URL(fileURLWithPath: temporaryFile)
        }
        
        guard let destination = CGImageDestinationCreateWithURL(fileURL! as CFURL, kUTTypeGIF, frameCount, nil) else {
            throw GIFManagerError.DestinationNotFound
        }
        
        CGImageDestinationSetProperties(destination, fileProperties as CFDictionary)
        
        let generator = AVAssetImageGenerator(asset: asset)
        
        generator.appliesPreferredTrackTransform = true
        if let size = size {
            generator.maximumSize = size
        }
        
        let tolerance = CMTimeMakeWithSeconds(Constants.Tolerance, preferredTimescale: Constants.TimeInterval)
        generator.requestedTimeToleranceBefore = tolerance
        generator.requestedTimeToleranceAfter = tolerance
        
        var times = [NSValue]()
        for time in timePoints {
            times.append(NSValue(time: time))
        }
        
        let gifGroup = Group()
        var dispatchError: Bool = false
        gifGroup.enter()
        
        generator.generateCGImagesAsynchronously(forTimes: times, completionHandler: { (requestedTime, image, actualTime, result, error) in
            guard let imageRef = image, error == nil else {
                print("An error occurred: \(String(describing: error)), image is \(String(describing: image))")
                dispatchError = true
                gifGroup.leave()
                return
            }
            
            CGImageDestinationAddImage(destination, imageRef, frameProperties as CFDictionary)
            
            if requestedTime == times.last?.timeValue {
                gifGroup.leave()
            }
        })
        
        gifGroup.wait()
        
        if dispatchError {
            throw GIFManagerError.AddFrameToDestination
        }
        
        CGImageDestinationSetProperties(destination, fileProperties as CFDictionary)
        
        if !CGImageDestinationFinalize(destination) {
            throw GIFManagerError.DestinationFinalize
        }
        
        return fileURL!
    }
}

