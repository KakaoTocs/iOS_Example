//
//  ViewController.swift
//  Alert
//
//  Created by Jinu Kim on 2018. 8. 17..
//  Copyright © 2018년 Jinu Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func touchUpShowAlerButton(_ sender: UIButton) {
        self.showAlertController(style: UIAlertControllerStyle.alert)
    }
    
    @IBAction func touchUpShowActionSheetButton(_ sender: UIButton) {
        self.showAlertController(style: UIAlertControllerStyle.actionSheet)
    }
    
    func showAlertController(style: UIAlertControllerStyle) {
        let alertController: UIAlertController
        alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: style)
        
        let okAction: UIAlertAction
        okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction) in
            print("OK pressed!")
        })
        
        let cancelAction: UIAlertAction
        cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        let handler: (UIAlertAction) -> Void
        handler = { (action: UIAlertAction) in
            print("action pressed \(action.title ?? "")")
        }
        
        let someAction: UIAlertAction
        someAction = UIAlertAction(title: "Some", style: UIAlertActionStyle.destructive, handler: handler)
        
        let anotherAction: UIAlertAction
        anotherAction = UIAlertAction(title: "Another", style: UIAlertActionStyle.cancel, handler: handler)
        
        alertController.addAction(someAction)
        alertController.addAction(anotherAction)
        
        if style == UIAlertControllerStyle.alert {
            alertController.addTextField { (field: UITextField) in
                field.placeholder = "플레이스 홀더"
                field.textColor = UIColor.red
            }
        }
        
        self.present(alertController, animated: true, completion: {
            print("Alert controller shown")
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

