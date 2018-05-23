//
//  DetailInfoViewController.swift
//  SignUp
//
//  Created by DGSW_TEACHER on 2018. 4. 10..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit

// 가입 버튼 비활성화
// 가입시 메인에 아이디 자동 입력
// 이전시 현재 입력된 정보 저장

class DetailInfoViewController: UIViewController {
    
    @IBOutlet weak var phoneNumberInputBox: UITextField!
    @IBOutlet weak var pickedBirthday: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        return formatter
    }()
    
    // MARK: 회원 가입 취소
    @IBAction func detailViewDismiss() {
        UserInformation.shared.clear()
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: 뒤로 가기
    @IBAction func previous() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: 회원 가입
    @IBAction func join() {
        /* add new user info */
        
        if phoneNumberInputBox.text != "",
            pickedBirthday.text != ""{
            UserInformation.shared.phoneNumber = phoneNumberInputBox.text
            UserInformation.shared.birthday = pickedBirthday.text
            
            UserInformation.shared.save()
            
            self.dismiss(animated: true, completion: nil)
        }
        else {
            print("빈칸을 확인 하세요")
        }
        
    }

    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker) {
        let date: Date = sender.date
        let dateString: String = self.dateFormatter.string(from: date)
        
        self.pickedBirthday.text = dateString
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.datePicker.addTarget(self, action: #selector(self.didDatePickerValueChanged(_:)), for: UIControlEvents.valueChanged)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
