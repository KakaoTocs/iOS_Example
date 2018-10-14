//
//  ViewController.swift
//  DelegatePattern
//
//  Created by Jinu Kim on 14/10/2018.
//  Copyright © 2018 Jinu Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var messageBox: MessageBox?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageBox = MessageBox(frame: CGRect(origin: .zero, size: CGSize(width: 300, height: 200)))
        if let msg = messageBox {
            msg.frame.origin = CGPoint(x: (UIScreen.main.bounds.width - msg.bounds.width) * 0.5,
                                       y: (UIScreen.main.bounds.height - msg.bounds.height) * 0.5)
            msg.backgroundColor = UIColor.lightGray
            msg.delegate = self
            self.view.addSubview(msg)
        }
    }
}

extension ViewController: MessageBoxDelegate {
    func touchButton() {
        print("touchButton")
    }
    
    func intro(id: String) {
        print(id)
    }
}

