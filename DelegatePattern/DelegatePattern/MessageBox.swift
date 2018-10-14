
//
//  MessageBox.swift
//  DelegatePattern
//
//  Created by Jinu Kim on 14/10/2018.
//  Copyright © 2018 Jinu Kim. All rights reserved.
//

import UIKit

@objc protocol MessageBoxDelegate: class {
    func touchButton()
    func intro(id: String)
}

class MessageBox: UIView {
    weak var delegate: MessageBoxDelegate?
    var button: UIButton?
    let id = "MsgBox"
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configure()
    }
    
    func configure() {
        button = UIButton(type: .system)
        if let btn = button {
            btn.setTitle("Send", for: .normal)
            btn.sizeToFit()
            btn.frame.origin = CGPoint(x: (self.bounds.width - btn.bounds.width) * 0.5,
                                       y: (self.bounds.height - btn.bounds.height) * 0.5)
            btn.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
            btn.addTarget(self, action: #selector(tapOutsideButton), for: .touchUpOutside)
            self.addSubview(btn)
        }
    }
    
    @objc func tapButton() {
        delegate?.touchButton()
    }
    
    @objc func tapOutsideButton() {
        delegate?.intro(id: id)
    }
}
