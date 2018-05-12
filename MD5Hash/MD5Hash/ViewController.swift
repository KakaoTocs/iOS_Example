//
//  ViewController.swift
//  MD5Hash
//
//  Created by DGSW_TEACHER on 2018. 5. 12..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var convertButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ConvertButtonAction(_ sender: UIButton) {
        let inputData = inputTextField?.text!
        outputTextView?.text = String.md5(inputData!)()
    }
    
}

