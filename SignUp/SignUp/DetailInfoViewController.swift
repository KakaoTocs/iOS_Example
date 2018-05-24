//
//  DetailInfoViewController.swift
//  SignUp
//
//  Created by DGSW_TEACHER on 2018. 4. 10..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit

// 가입 버튼 비활성화
// 이전시 현재 입력된 정보 저장

class DetailInfoViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var phoneNumberInputBox: UITextField!
    @IBOutlet weak var pickedBirthday: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var joinButton: UIButton!
    
    var birthdayPickState = false
    
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일"
        
        return formatter
    }()
    
    // MARK: 회원가입 취소
    @IBAction func detailViewDismiss() {
        UserInformation.shared.clear()
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: 뒤로 가기
    @IBAction func previous() {
        if let phoneNumber = phoneNumberInputBox.text {
            UserInformation.shared.phoneNumber = phoneNumber
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: 회원가입
    @IBAction func join() {
        if birthdayPickState,
            phoneNumberInputBox.text != "" {
            
            UserInformation.shared.save()
            
            self.dismiss(animated: true, completion: nil)
        }
        else {
            print("빈칸을 확인 하세요")
        }
    }

    // 생일 선택 했을때
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker) {
        let date: Date = sender.date
        let dateString: String = self.dateFormatter.string(from: date)
        
        self.pickedBirthday.text = dateString
        UserInformation.shared.birthday = dateString

        birthdayPickState = true
        
        if let phoneNumber = phoneNumberInputBox.text,
            phoneNumber != "" {
            joinButton.isEnabled = true
        } else {
            joinButton.isEnabled = false
        }
    }
    
    // 전화번호입력이 끝났을때
    @IBAction func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            if birthdayPickState,
                let phoneNumber = textField.text,
                phoneNumber != "" {
                UserInformation.shared.phoneNumber = phoneNumber
                joinButton.isEnabled = true
            } else {
                joinButton.isEnabled = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        joinButton.isEnabled = false
        self.datePicker.addTarget(self, action: #selector(self.didDatePickerValueChanged(_:)), for: UIControlEvents.valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var nextState = false
        if let phoneNumber = UserInformation.shared.phoneNumber,
            phoneNumber != "" {
            phoneNumberInputBox.text = phoneNumber
        } else {
            nextState = true
        }
        if let birthday = UserInformation.shared.birthday,
            birthday != "" {
            pickedBirthday.text = birthday
            birthdayPickState = true
        } else {
            joinButton.isEnabled = false
            return
        }
        
        if nextState {
            joinButton.isEnabled = false
            return
        }
        
        joinButton.isEnabled = true
    }
    
    // 키보드 토글
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
