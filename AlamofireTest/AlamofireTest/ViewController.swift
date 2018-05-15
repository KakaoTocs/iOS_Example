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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        guard let url = URL(string: "10.80.161.231") else {
            return
        }
        Alamofire.request(url, method: .get)
//        .validate()
        .responseJSON { response in
            print(response)
            guard response.result.isSuccess else {
                print("Error")
                return
            }
            
//            guard let value = response.result.value as? [String: Any] else {
//                print("Type Error")
//            }
            
            print(response)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

