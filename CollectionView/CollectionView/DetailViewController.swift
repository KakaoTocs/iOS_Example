//
//  DetailViewController.swift
//  CollectionView
//
//  Created by Kim on 2018. 5. 30..
//  Copyright © 2018년 Kim. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var program: Program?
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let program = program {
            navigationItem.title = program.name!
            imageView.image = UIImage(named: program.name!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
