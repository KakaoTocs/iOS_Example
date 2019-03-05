//
//  ViewController.swift
//  DynamicAppIcon
//
//  Created by Jinu Kim on 19/02/2019.
//  Copyright © 2019 com.kakaotocs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func Icon1ButtonAction(_ sender: UIButton) {
        changeIcon(to: "Icon1")
    }
    
    @IBAction func Icon2ButtonAction(_ sender: UIButton) {
        changeIcon(to: "Icon2")
    }
    
    @IBAction func Icon3ButtonAction(_ sender: UIButton) {
        changeIcon(to: "Icon3")
    }
    
    func changeIcon(to iconName: String) {
        guard UIApplication.shared.supportsAlternateIcons else {
            return
        }
        
        UIApplication.shared.setAlternateIconName(iconName, completionHandler: { (error) in
            if let error = error {
                print("App icon faild to change due to \(error.localizedDescription)")
            } else {
                print("App icon changed successfully")
            }
        })
    }
}

