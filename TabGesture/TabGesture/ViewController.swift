//
//  ViewController.swift
//  TabGesture
//
//  Created by DGSW_TEACHER on 2018. 4. 5..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tapGesuture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesuture.delegate = self
        
        self.view.addGestureRecognizer(tapGesuture)
        /*
        let tapGesture: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.tapView(_:)))
        
        self.view.addGestureRecognizer(tapGesture)
        */
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

