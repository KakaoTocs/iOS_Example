//
//  ThirdViewController.swift
//  Notification
//
//  Created by Jinu Kim on 2018. 8. 21..
//  Copyright © 2018년 Jinu Kim. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.test(_:)), name: notificationKey, object: nil)
    }
    
    @IBAction func sendNotiButtonAction(_ sender: UIButton) {
        NotificationCenter.default.post(name: notificationKey, object: nil, userInfo: ["Data":"Hello Observer From ThirdView"])
    }
    
    @objc func test(_ noti: Notification) {
        guard let realData: String = noti.userInfo?["Data"] as? String else {
            return
        }
        
        print("Third: \(realData)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
