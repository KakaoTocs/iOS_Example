//
//  ViewController.swift
//  SocketStream
//
//  Created by DGSW_TEACHER on 2018. 5. 17..
//  Copyright © 2018??KakaoTocs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputTextView: UITextView!
    
    let socket = Socket()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func connectAction(_ sender: Any) {
        socket.connectToServer(host: "www.naver.com", port: 80)
    }
    
    @IBAction func readDataAction(_ sender: Any) {
        let bufferSize = 1024
        let chunk = socket.receiveData(bufferSize: bufferSize)
        var getString: String?
        
        if chunk.count > 0 {
            getString = String(bytes: chunk, encoding: String.Encoding.utf8)!
            outputTextView?.text = getString!
        }
    }
    
    @IBAction func sendDataAction(_ sender: Any) {
        let query = inputTextField?.text
        let queryData = query?.data(using: String.Encoding.utf8, allowLossyConversion: true)
        let sentCount = socket.send(data: queryData!)
        print("sendData: \(sentCount)")
    }
}

