//
//  DetailInfoViewController.swift
//  SignUp
//
//  Created by DGSW_TEACHER on 2018. 4. 10..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit

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
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: 뒤로 가기
    @IBAction func previous() {
        /* roll back data to placeholder */
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: 회원 가입
    @IBAction func join() {
        /* add new user info */
        
        if phoneNumberInputBox.text != "" {
            UserInformation.shared.userDetailInfo["phoneNumber"] = phoneNumberInputBox.text
            UserInformation.shared.userDetailInfo["birthday"] = pickedBirthday.text
            
            UserInformation.save(user: UserInformation.shared)
            
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
        
        let date: Date = self.datePicker.date
        let dateString: String = self.dateFormatter.string(from: date)
        pickedBirthday.text = dateString
        
        self.datePicker.addTarget(self, action: #selector(self.didDatePickerValueChanged(_:)), for: UIControlEvents.valueChanged)
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
