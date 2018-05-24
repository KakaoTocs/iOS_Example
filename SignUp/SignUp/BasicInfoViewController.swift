//
//  BasicInfoViewController.swift
//  SignUp
//
//  Created by DGSW_TEACHER on 2018. 4. 10..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit
import Photos

class BasicInfoViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var idInputBox: UITextField!
    @IBOutlet weak var pwInputBox: UITextField!
    @IBOutlet weak var pwCheckInputBox: UITextField!
    @IBOutlet weak var introInputBox: UITextView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    
    var pwTemp: String = "", pwCheckTemp: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 다음 버튼 비활성화
        nextButton.isEnabled = false
        // 프로필 이미지 터치 설정
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileImageTapped)))
    }
    
    // 네비게이션바 숨기기
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: 취소 버튼
    @IBAction func cancelButtonAction() {
        UserInformation.shared.clear()
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: 다음 버튼
    @IBAction func nextButtonAction() {
        UserInformation.shared.id = idInputBox.text
        UserInformation.shared.pw = pwInputBox.text
        UserInformation.shared.introduce = introInputBox.text
        UserInformation.shared.profileImage = profileImage.image
        
        // 다음 뷰로 전환
        if let detailInfoViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailInfoView") as? DetailInfoViewController {
            self.navigationController?.pushViewController(detailInfoViewController, animated: true)
        }
    }
    
    // MARK: 정보 입력이 끝났을때
    @IBAction func textFieldDidEndEditing(_ textField: UITextField) {
        // textFiled 값 읽기
        switch textField.tag {
            case 2:
                pwTemp = textField.text!
            case 3:
                pwCheckTemp = textField.text!
            default:
                return
        }
        // 다음 버튼 활성화 여부
        if pwTemp == pwCheckTemp,
            pwTemp != "",
            idInputBox.text! != "",
            introInputBox.text! != "",
            profileImage.image != nil {
            nextButton.isEnabled = true
        }
        else {
            nextButton.isEnabled = false
        }
    }
    
    internal func textViewDidEndEditing(_ textView: UITextView) {
        if pwTemp == pwCheckTemp,
            pwTemp != "",
            idInputBox.text! != "",
            introInputBox.text! != "",
            profileImage.image != nil {
            nextButton.isEnabled = true
        }
        else {
            nextButton.isEnabled = false
        }
    }
    
    // imagePicker 생성
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        
        return picker
    }()

    // MARK: 프로필 사진 터치
    @objc func profileImageTapped(sender: UITapGestureRecognizer) {
        if(sender.state == .ended) {
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    // imagePicker Cancel 버튼 생성
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage: UIImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.profileImage.image = pickedImage
        }
        
        if pwTemp == pwCheckTemp,
            pwTemp != "",
            idInputBox.text! != "",
            introInputBox.text! != "",
            profileImage.image != nil {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: 키보드 토글 설정
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
