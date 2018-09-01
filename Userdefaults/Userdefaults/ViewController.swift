//
//  ViewController.swift
//  Userdefaults
//
//  Created by Jinu Kim on 2018. 9. 1..
//  Copyright © 2018년 Jinu Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        if var dbDatas: Array<String> = defaults.object(forKey: "data") as? Array<String> {
            dbDatas.append(inputTextField.text ?? "")
            defaults.set(dbDatas, forKey: "data")
        } else {
            defaults.set([inputTextField.text ?? ""], forKey: "data")
        }
    }
    
    @IBAction func readButtonAction(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        if let dbDatas: Array<String> = defaults.object(forKey: "data") as? Array<String> {
            outputTextView.text = ""
            for data in dbDatas {
                outputTextView.text.append(data)
                outputTextView.text.append("\n")
            }
        } else {
            outputTextView.text = "No Data"
        }
    }
}

