//
//  ViewController.swift
//  AlamofireTest
//
//  Created by DGSW_TEACHER on 2018. 5. 15..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonAction(_ sender: Any) {
        request("http://www.httpbin.org/get").responseJSON { response in
            if let JSON = response.value {
                var jsonObject = JSON as! [String: AnyObject]
                let origin = jsonObject["origin"] as! String
                let url = jsonObject["url"] as! String
                
                var temp = "JSON: \(jsonObject)"
                temp.append("\nIP Address Origin: \(origin)")
                temp.append("\nURL of Request: \(url)")
                print("Hello, this is message 1")
                
                self.textView.text = temp
            }
        }
        print("Hello, this is message 2")
    }
    
}

