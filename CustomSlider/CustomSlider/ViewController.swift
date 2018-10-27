//
//  ViewController.swift
//  CustomSlider
//
//  Created by Jinu Kim on 27/10/2018.
//  Copyright © 2018 Jinu Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.minimumValueImage = UIImage(named: "SoundZ")
        slider.maximumValueImage = UIImage(named: "SoundF")
        slider.thumbTintColor = UIColor.black
        slider.minimumTrackTintColor = UIColor.green
        slider.maximumTrackTintColor = UIColor.brown
    }


}

