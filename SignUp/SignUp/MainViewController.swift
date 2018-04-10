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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpButtonAction() {
        let detailInfoViewController = DetailInfoViewController.instantiate (self.storyboard!)
        detailInfoViewController.modalPresentationStyle = .overCurrentContext
        present(detailInfoViewController, animated: true, completion: nil)
    }
    
    @IBAction func signInButtonAction(_ sender: UIButton) {
        assert(true, "Login!")
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
