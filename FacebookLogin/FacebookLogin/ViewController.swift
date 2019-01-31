//
//  ViewController.swift
//  FacebookLogin
//
//  Created by Jinu Kim on 17/01/2019.
//  Copyright © 2019 com.kakaotocs. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loginResultLabel: UILabel!
    @IBOutlet weak var userInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        loginButton.delegate = self
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        loginButton.center = view.center
        view.addSubview(loginButton)
        
        if FBSDKAccessToken.current() != nil {
            let token = FBSDKAccessToken.current()
            self.userInfoLabel.text = "token: \(token?.userID)\nappID: \(token?.appID))"
            print("\(token?.tokenString)")
            self.loginResultLabel.text = "Keep User Login"
        } else {
            self.loginResultLabel.text = "Not yet login"
        }
    }
}

extension ViewController: FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            self.loginResultLabel.text = error.localizedDescription
        } else if result.isCancelled {
            self.loginResultLabel.text = "User cancel login"
        } else {
            let token = FBSDKAccessToken.current()
            self.userInfoLabel.text = "token: \(token?.userID)\nappID: \(token?.appID))"
            print("\(token?.tokenString)")
            self.loginResultLabel.text = "User Login"
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        self.loginResultLabel.text = "User logged out"
    }
}
