//
//  Socket.swift
//  SocketStream
//
//  Created by DGSW_TEACHER on 2018. 5. 17..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import Foundation

class Socket: NSObject, StreamDelegate {
    
    var host: String?
    var port: Int?
    var inputStream: InputStream?
    var outputStream: OutputStream?
//    var readStream: Unmanaged<CFReadStream>?
//    var writeStream: Unmanaged<CFWriteStream>?
    
    func connectToServer(host: String, port: Int) {
        
        self.host = host
        self.port = port
        
//        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, host as CFString, UInt32(port), &readStream, &writeStream)
        
        Stream.getStreamsToHost(withName: host, port: port, inputStream: &inputStream, outputStream: &outputStream)
        
        if inputStream != nil && outputStream != nil {
//            print("Not Null")
            
//            inputStream = readStream!.takeRetainedValue()
//            outputStream = writeStream!.takeRetainedValue()
            
            inputStream!.delegate = self
            outputStream!.delegate = self
            
//            inputStream!.schedule(in: .current, forMode: .commonModes)
//            outputStream!.schedule(in: .current, forMode: .commonModes)
            inputStream!.schedule(in: .main, forMode: RunLoopMode.defaultRunLoopMode)
            outputStream!.schedule(in: .main, forMode: RunLoopMode.defaultRunLoopMode)
            
            inputStream!.open()
            outputStream!.open()
        }
        
    }
    
    func disconnect() {
        inputStream?.close()
        outputStream?.close()
    }
    
    func send(data: Data) -> Int {
        let bytesWritten = data.withUnsafeBytes { outputStream?.write($0, maxLength: data.count) }
        return bytesWritten!
    }
    
    func receiveData(bufferSize: Int) -> Data {
        /*
        var buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        
        while (inputStream?.hasBytesAvailable)! {
            let numberOfBytesRead = inputStream?.read(buffer, maxLength: bufferSize)
            if numberOfBytesRead! < 0 {
                if let _ = inputStream?.streamError {
                    break
                }
            }
            
            if numberOfBytesRead! > 0 {
                let output = String(cString: buffer)
            } else {
                NSLog("Empty String")
            }
        }
        buffer.deallocate(capacity: bufferSize)
        return Data(base64Encoded: "HI")!
        */
        
        var buffer = [UInt8](repeating: 0, count: bufferSize)
        
        let bytesRead = inputStream?.read(&buffer, maxLength: bufferSize)
        
        var dropCount = bufferSize - bytesRead!
        
        if dropCount < 0 {
            dropCount = 0
        }
        let chunk = buffer.dropLast(dropCount)
        print(buffer)
        
        return Data(buffer)
        
    }
    
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        if aStream === inputStream {
            switch eventCode {
            case Stream.Event.errorOccurred:
                print("inputStream: ErrorOccurred")
            case Stream.Event.openCompleted:
                print("inputStream: OpenCompleted")
            case Stream.Event.hasBytesAvailable:
                print("inputStream: HasBytesAvilable")
                var buffer = [UInt8](repeating: 0, count: 1024)
                let bytesRead = inputStream?.read(&buffer, maxLength: 1024)
                var dropCount = 1024 - bytesRead!
                
            case Stream.Event.hasBytesAvailable:
                print("읽을 바이트가 있음")
                
            default:
                break
            }
        }
        else  if aStream === outputStream {
            switch eventCode {
            case Stream.Event.errorOccurred:
                print("outputStream: ErrorOccurred")
            case Stream.Event.openCompleted:
                print("outputStream: OpenCompleted")
            case Stream.Event.hasBytesAvailable:
                print("outputStream: HasBytesAvilable")
            case Stream.Event.hasBytesAvailable:
                print("읽을 바이트가 있음")
                
            default:
                break
            }
        }
    }
    
}
