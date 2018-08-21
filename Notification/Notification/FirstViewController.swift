//
//  ViewController.swift
//  Notification
//
//  Created by Jinu Kim on 2018. 8. 21..
//  Copyright © 2018년 Jinu Kim. All rights reserved.
//

import UIKit

let notificationKey: Notification.Name = Notification.Name("observer")

class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.test(_:)), name: notificationKey, object: nil)
    }
    
    @IBAction func sendNotiButtonAction(_ sender: UIButton) {
        NotificationCenter.default.post(name: notificationKey, object: nil, userInfo: ["Data":"Hello Observer From FirstView"])
    }
    @objc func test(_ noti: Notification) {
        guard let realData: String = noti.userInfo?["Data"] as? String else {
            return
        }
        
        print("First: \(realData)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
