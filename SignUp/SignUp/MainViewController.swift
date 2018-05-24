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
        
        initialData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: 로그인 버튼
    @IBAction func signInButton() {
        if let id: String = idInputBox.text,
            let pw: String = passwordInputBox.text,
            id != "",
            pw != "" {

            UserInformation.shared.id = id
            UserInformation.shared.pw = pw

            if(UserInformation.shared.check()) {
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
    
    // MARK: 키보드 토글
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // UserDefaults 초기화
    func initialData() -> Void {
        let defaults = UserDefaults.standard
        
        let ids: Array<String> = [""]
        let pws: Array<String> = [""]
        
        defaults.set(ids, forKey: "ids")
        defaults.set(pws, forKey: "pws")

    }

}
