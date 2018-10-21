//
//  ViewController.swift
//  ImageBlur
//
//  Created by Jinu Kim on 22/10/2018.
//  Copyright © 2018 Jinu Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    let effect = UIBlurEffect(style: .dark)
    lazy var effectView: UIVisualEffectView = {
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = self.view.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return effectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageView.image = UIImage(named: "image.jpg")
        self.view.addSubview(effectView)
    }


}

