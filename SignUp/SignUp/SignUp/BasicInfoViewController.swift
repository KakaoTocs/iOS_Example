//
//  BasicInfoViewController.swift
//  SignUp
//
//  Created by DGSW_TEACHER on 2018. 4. 10..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//
// MARK: 키보드
// https://m.blog.naver.com/PostView.nhn?blogId=zll11&logNo=220736376768&proxyReferer=https%3A%2F%2Fwww.google.co.kr%2F
import UIKit

class BasicInfoViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var idInputBox: UITextField!
    @IBOutlet weak var pwInputBox: UITextField!
    @IBOutlet weak var pwCheckInputBox: UITextField!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var introInputBox: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var pwTemp: String = "", pwCheckTemp: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nextButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: 취소 버튼
    @IBAction func cancelButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: 다음 버튼
    @IBAction func nextButtonAction() {
        
        if introInputBox.text == "", idInputBox.text != "", pwInputBox.text != "" {
            print("intro \"\"")
        }
        else {
            UserInformation.shared.id = idInputBox.text
            UserInformation.shared.pw = pwInputBox.text
            UserInformation.shared.userDetailInfo["selfIntro"] = introInputBox.text
            
            if let detailInfoViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailInfoView") as? DetailInfoViewController {
                self.navigationController?.pushViewController(detailInfoViewController, animated: true)
            }
        }
    }
    
    @IBAction func textFieldDidEndEditing(_ textField: UITextField) {
        // MARK: textFiled 값 읽기
        switch textField.tag {
            case 2:
                pwTemp = textField.text!
            case 3:
                pwCheckTemp = textField.text!
            default:
                return
        }
        
        // MARK: 다음 버튼 활성화 여부
        if pwTemp != pwCheckTemp || pwTemp == "" {
            nextButton.isEnabled = false
        }
        else {
            nextButton.isEnabled = true
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
