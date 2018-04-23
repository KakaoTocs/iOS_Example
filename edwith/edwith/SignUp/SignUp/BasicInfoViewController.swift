//
//  BasicInfoViewController.swift
//  SignUp
//
//  Created by DGSW_TEACHER on 2018. 4. 10..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//
// MARK: 키보드
// https://m.blog.naver.com/PostView.nhn?blogId=zll11&logNo=220736376768&proxyReferer=https%3A%2F%2Fwww.google.co.kr%2F
// 폴더 관리
// https://iosdevcenters.blogspot.com/2016/04/save-and-get-image-from-document.html
// GPS 위치 정보 받기
// http://tom7930.tistory.com/28?category=645776
// 카메라로 찍은 사진 정보 info[UIImagePickerControllerMediaMetadata]

// 사진 관련 정보 사이트
//https://dev.classmethod.jp/references/ios8-photo-kit-8/

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

        // Do any additional setup after loading the view.
        
        nextButton.isEnabled = false
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileImageTapped)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
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
        if pwTemp == pwCheckTemp && pwTemp != "" && idInputBox.text! != "" && introInputBox.text! != "" {
            nextButton.isEnabled = true
        }
        else {
            nextButton.isEnabled = false
        }
    }
    
    internal func textViewDidEndEditing(_ textView: UITextView) {
        if pwTemp == pwCheckTemp && pwTemp != "" && idInputBox.text! != "" && introInputBox.text! != "" {
            nextButton.isEnabled = true
        }
        else {
            nextButton.isEnabled = false
        }
    }
    
    // MARK: 프로필 사진 터치
    @objc func profileImageTapped(sender: UITapGestureRecognizer) {
        if(sender.state == .ended) {
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        
        return picker
    }()
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage: UIImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.profileImage.image = pickedImage
            
            if let asset = info[UIImagePickerControllerPHAsset] as? PHAsset {
                if let fileName = (asset.value(forKey: "filename")) as? String {
                    print(fileName)
                }
//                if let temp = PHAsset.fetchAssets
            }
            /*
            if let imageUrl: URL = info[UIImagePickerControllerReferenceURL] as? URL{
                if let asset: PHAsset = PHAsset.fetchAssets(withALAssetURLs: [imageUrl], options: nil).firstObject as! PHAsset {
                    print(asset.location)
                    print(asset.creationDate)
                }
                else {
                    print("Fail")
                }
            }
            else {
                print("no metadata")
            }
            */
        }
        self.dismiss(animated: true, completion: nil)
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
