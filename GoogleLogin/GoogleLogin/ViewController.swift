//
//  ViewController.swift
//  GoogleLogin
//
//  Created by Jinu Kim on 23/01/2019.
//  Copyright © 2019 com.kakaotocs. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var loginResultView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
//        GIDSignIn.sharedInstance().signInSilently()
    }
    
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            loginResultView.text = ""
            loginResultView.text.append("AccessToken: \(user.authentication.accessToken)\n\n")
            loginResultView.text.append("UserID: \(userId)\n\n")
            loginResultView.text.append("IDToken: \(idToken)\n\n")
            loginResultView.text.append("FullName: \(fullName)\n\n")
            loginResultView.text.append("GivenName: \(givenName)\n\n")
            loginResultView.text.append("FamilyName: \(familyName)\n\n")
            loginResultView.text.append("Email: \(email)")
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        print("User Disconnected")
        loginResultView.text = "User Disconnected"
    }
    
    // 108824009671-b717t8a9age923pajlcaej4g7vhn93c2.apps.googleusercontent.com
}

