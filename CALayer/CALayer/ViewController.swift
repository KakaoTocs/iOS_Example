//
//  ViewController.swift
//  CALayer
//
//  Created by Jinu Kim on 18/02/2019.
//  Copyright © 2019 com.kakaotocs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let subView = UIView(frame: CGRect(x: 50, y: 50, width: 256, height: 256))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(subView)
        
        subView.backgroundColor = UIColor.black
        
        let layer = CALayer()
        layer.frame = CGRect(x: 10, y: 10, width: 236, height: 236)
        layer.backgroundColor = UIColor.white.cgColor
        subView.layer.addSublayer(layer)
        
        layer.cornerRadius = 40
        
        let image = UIImage(named: "apple.png")
        layer.contents = image?.cgImage
        layer.masksToBounds = true
        
        let swiftLayer = CALayer()
        swiftLayer.frame = CGRect(x: 20, y: 20, width: 75, height: 68)
//        swiftLayer.backgroundColor = UIColor.white.cgColor
        swiftLayer.contents = UIImage(named: "swift.png")?.cgImage
        layer.addSublayer(swiftLayer)
        
        swiftLayer.shadowOffset = CGSize(width: 5, height: 5)
        swiftLayer.shadowRadius = 5
        swiftLayer.shadowOpacity = 0.8
    }


}

