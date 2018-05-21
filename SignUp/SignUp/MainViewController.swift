//
//  MainViewController.swift
//  SignUp
//
//  Created by DGSW_TEACHER on 2018. 4. 10..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
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
        if let id: String = idInputBox.text,
            let pw: String = passwordInputBox.text,
            id != "",
            pw != "" {
            
            if(UserInformation.check(id: id, pw: pw)) {
                print("로그인 성공!!")
            }
            else {
                print("아이디 또는 비밀번호가 틀렸습니다.")
            }
        }
        else {
            print("아이디 혹은 비밀번호가 입력 되었는지 확인 하세요.")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
