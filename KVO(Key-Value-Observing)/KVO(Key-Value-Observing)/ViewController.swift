//
//  ViewController.swift
//  KVO(Key-Value-Observing)
//
//  Created by Jinu Kim on 06/01/2019.
//  Copyright © 2019 com.kakaotocs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var observations: [NSKeyValueObservation] = []
    let configurationManager = ConfigurationManager(withConfiguration: Configuration(createdAt: Date(), updatedAt: Date()))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupObserver()
    }

    func setupObserver() {
        let dateObservation = configurationManager.configuration.observe(\.updatedAt, options: [.initial, .new]) { [weak self] (observed, changed) in
            self?.label.text = self?.configurationManager.dateFormatter.string(from: changed.newValue!)
        }
        observations.append(dateObservation)
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        configurationManager.updateConfiguration()
    }
    
    deinit {
        observations.removeAll()
    }

}

