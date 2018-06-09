//
//  ViewController.swift
//  CustomCamera
//
//  Created by Kim on 2018. 6. 5..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class ViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    var captureSession: AVCaptureSession?
    var capturePhotoOutput: AVCapturePhotoOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    @objc var captureDevice: AVCaptureDevice?
    
    @IBOutlet weak var exposure: UILabel!
    @IBOutlet weak var iso: UILabel!
    @IBOutlet weak var lensPosition: UILabel!
    @IBOutlet var preView: UIView!
    
    @IBOutlet var capture: UIButton!
    @IBAction func capture(_ sender: Any) {
        let photoSettings : AVCapturePhotoSettings!
        photoSettings = AVCapturePhotoSettings.init(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.flashMode = .off
        photoSettings.isHighResolutionPhotoEnabled = false
        self.capturePhotoOutput?.capturePhoto(with: photoSettings, delegate: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let screenSize = previewLayer?.bounds.size
        if let touchPoint = touches.first {
            let x = touchPoint.location(in: preView).y / (screenSize?.height)!
            let y = 1.0 - touchPoint.location(in: preView).x / (screenSize?.width)!
            let focusPoint = CGPoint(x: x, y: y)
            print("초점: \(focusPoint)")
            if let device = captureDevice {
                do {
                    try device.lockForConfiguration()
                    
                    device.focusMode = .autoFocus
                    device.exposurePointOfInterest = focusPoint
                    device.exposureMode = AVCaptureDevice.ExposureMode.continuousAutoExposure
                    device.unlockForConfiguration()
                } catch {
                    print("포커스 에러")
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.captureSession = AVCaptureSession()
        self.captureSession?.sessionPreset = .photo
        self.capturePhotoOutput = AVCapturePhotoOutput()
        self.captureDevice = AVCaptureDevice.default(for: .video)
//        self.captureDevice?.focusMode = .autoFocus
//        self.captureDevice?.lockForConfiguration(nil)
//        self.captureDevice?.focusPointOfInterest =
        let input = try! AVCaptureDeviceInput(device: self.captureDevice!)
        self.captureSession?.addInput(input)
        self.captureSession?.addOutput(self.capturePhotoOutput!)
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession!)
        self.previewLayer?.frame = self.preView.bounds
        self.previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.previewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        self.preView.layer.addSublayer(self.previewLayer!)
        
        self.captureSession?.startRunning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeObservers()
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        PHPhotoLibrary.shared().performChanges( {
            let creationRequest = PHAssetCreationRequest.forAsset()
            creationRequest.addResource(with: PHAssetResourceType.photo, data: photo.fileDataRepresentation()!, options: nil)
        }, completionHandler: nil)
    }
    
    func photoOutput(_ captureOutput: AVCapturePhotoOutput,
                     didFinishCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings,
                     error: Error?) {

        guard error == nil else {
            print("Error in capture process: \(String(describing: error))")
            return
        }
    }
    
    func addObservers() {
        self.addObserver(self, forKeyPath: "captureDevice.lensPosition" , options: .new, context: nil)
        self.addObserver(self, forKeyPath: "captureDevice.exposureDuration", options: .new, context: nil)
        self.addObserver(self, forKeyPath: "captureDevice.ISO", options: .new, context: nil)
    }
    
    func removeObservers() {
        self.removeObserver(self, forKeyPath: "captureDevice.lensPosition")
        self.removeObserver(self, forKeyPath: "captureDevice.exposureDuration")
        self.removeObserver(self, forKeyPath: "captureDevice.ISO")
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey: Any]?,
                               context: UnsafeMutableRawPointer?) {
        
        if keyPath == "captureDevice.lensPosition" {
            self.lensPosition.text = String(format: "%.1f", (self.captureDevice?.lensPosition)!)
        }
        
        if keyPath == "captureDevice.exposureDuration" {
            let exposureDurationSeconds = CMTimeGetSeconds( (self.captureDevice?.exposureDuration)! )
            self.exposure.text = String(format: "1/%.f", 1.0 / exposureDurationSeconds)
        }
        
        if keyPath == "captureDevice.ISO" {
            self.iso.text = String(format: "%.f", (self.captureDevice?.iso)!)
//            self.captureDevice?.
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
