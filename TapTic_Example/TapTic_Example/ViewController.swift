//
//  ViewController.swift
//  TapTic_Example
//
//  Created by Jinu Kim on 17/02/2019.
//  Copyright © 2019 com.kakaotocs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let impact = UIImpactFeedbackGenerator()
    let selection = UISelectionFeedbackGenerator()
    let notification = UINotificationFeedbackGenerator()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func impactOccuredButtonAction(_ sender: UIButton) {
        impact.impactOccurred()
    }
    
    @IBAction func selectionChangedButtionAction(_ sender: UIButton) {
        selection.selectionChanged()
    }
    
    @IBAction func notificationSuccessButtonAction(_ sender: UIButton) {
        notification.notificationOccurred(.success)
    }
    
    @IBAction func notificationWarringButtonAction(_ sender: UIButton) {
        notification.notificationOccurred(.warning)
    }
    
    @IBAction func notificationErrorButtonAction(_ sender: UIButton) {
        notification.notificationOccurred(.error)
    }
    
}

