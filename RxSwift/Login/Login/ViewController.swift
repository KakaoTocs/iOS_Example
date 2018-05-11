//
//  ViewController.swift
//  Login
//
//  Created by DGSW_TEACHER on 2018. 5. 11..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var userPWTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton?.backgroundColor = UIColor.red
        self.loginButton?.isUserInteractionEnabled = false
        
        guard let _userIDTextField = userIDTextField, let _userPWTextField = userPWTextField else {
            return
        }
        
        let validUserID = _userIDTextField.rx.text
            .distinctUntilChanged()
            .throttle(0.5, scheduler: MainScheduler.instance)
            .map { ($0?.characters.count)! > 0 }
        
        let validPassword = _userPWTextField.rx.text
            .distinctUntilChanged()
            .map { ($0?.characters.count)! > 0 }
        
        let validCredentials = Observable.combineLatest(validUserID, validPassword) { (valid1, valid2) -> Bool in
            return valid1 && valid2
        }
        
        validCredentials.subscribe(onNext: { [unowned self] (isValid) in
            self.loginButton?.backgroundColor = isValid ? UIColor.green : UIColor.red
            self.loginButton?.isUserInteractionEnabled = isValid
        })
        .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

