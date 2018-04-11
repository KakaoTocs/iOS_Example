//
//  MainViewController.swift
//  SignUp
//
//  Created by DGSW_TEACHER on 2018. 4. 10..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
     // !! basic info input view 모달 present 부터!!--------------------------------------
    @IBOutlet weak var idInputBox: UITextField!
    @IBOutlet weak var passwordInputBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        let ids: Array<String> = [""]
        let pws: Array<String> = [""]
        
        defaults.set(ids, forKey: "ids")
        defaults.set(pws, forKey: "pws")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInButton() {
        let defaults = UserDefaults.standard
    
        if let id: String = idInputBox.text, let pw: String = passwordInputBox.text, id != "", pw != "" {
            let ids: Array<String> = defaults.object(forKey: "ids") as! Array<String>
            let pws: Array<String> = defaults.object(forKey: "pws") as! Array<String>
            
            if(ids.contains(id) && pws.contains(pw)) {
                print("Login Success")
            }
            else {
                print("ID or Password Error")
            }
        }
        else {
            print("Check ID or Password")
        }
    }
    
    @IBAction func signUpButton() {
        if let basicInfoViewController = self.storyboard?.instantiateViewController(withIdentifier: "BasicInfoView") as? BasicInfoViewController {
            self.present(basicInfoViewController, animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
