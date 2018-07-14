//
//  ViewController.swift
//  SocketStream
//
//  Created by DGSW_TEACHER on 2018. 5. 17..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var connectInfoView: UITextView!
    @IBOutlet weak var detailInfoView: UITextView!
    
    var temp: String = ""
    let socket = Socket()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func connectAction(_ sender: Any) {
        socket.connectToServer(host: "www.phenology.info", port: 5109)
//        socket.connectToServer(host: "www.naver.com", port: 80)
    }
    
    @IBAction func readDataAction(_ sender: Any) {
        let bufferSize = 1024
        let chunk = socket.receiveData(bufferSize: bufferSize)
        var getString: String?
        
        if chunk.count > 0 {
            getString = String(bytes: chunk, encoding: String.Encoding.utf8)!
            detailInfoView?.text.append(getString!)
        }
        print("readData: \(chunk)")
    }
    
    @IBAction func sendDataAction(_ sender: Any) {
        let PW: String = "dlwlstjd"
        //
        let temp: String = "0000"
        let opCode: String = "3"//String(bytes: toByteArray(3 as Int), encoding: String.Encoding.utf8)!
        let ID: String = "sunge227"
        let idSize: String = "\((ID.characters.count) + 1)000"//String(bytes: toByteArray(((ID.characters.count) + 1) as Int), encoding: String.Encoding.utf8)!
        let separator: String = "\0"
        let pwMD5: String = PW //String.toMD5(PW)()
        let end: String = "0"//String(bytes: toByteArray(0 as Int), encoding: String.Encoding.utf8)!
        let android: [UInt8] = [3, 0, 0, 0, 9, 115, 117, 110, 103, 101, 50, 50, 55, 0, 57, 52, 53, 55, 100, 48, 55, 56, 57, 100, 57, 57, 56, 50, 54, 100, 102, 102, 51, 51, 97, 56, 56, 98, 53, 54, 48, 57, 101, 98, 0]
        let androidString: String = fromByteArray(android, String.self)
//        print(androidString)
        let query: String = temp + opCode + idSize + ID + separator + pwMD5 + end
        print(query)

        let queryData = query.data(using: String.Encoding.utf8, allowLossyConversion: true)
//        let queryData = androidString.data(using: String.Encoding.utf8, allowLossyConversion: true)
        let array = [UInt8](queryData!)
        print(array)

        let sentCount = socket.send(data: queryData!)
        print("sendData: \(sentCount)")
    }
    
    @IBAction func disconnectionAction(_ sender: Any) {
        socket.disconnect()
    }
    
    func writeDetailInfo(info: String) {
        temp.append(info)
         self.connectInfoView?.text = temp
        
    }
}

