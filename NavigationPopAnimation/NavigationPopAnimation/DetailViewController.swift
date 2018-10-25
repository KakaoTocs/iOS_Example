//
//  DetailViewController.swift
//  NavigationPopAnimation
//
//  Created by Jinu Kim on 24/10/2018.
//  Copyright © 2018 Jinu Kim. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let image = UIImage(named: imageName ?? "") {
            self.imageView.image = image
        }
    }
}
