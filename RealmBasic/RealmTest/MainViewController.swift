//
//  MainViewController.swift
//  RealmTest
//
//  Created by user on 06/07/2018.
//  Copyright © 2018 KakaoTocs. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var inputUserName: UITextField!
    @IBOutlet weak var inputUserAge: UITextField!
    @IBOutlet weak var inputUserEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func addPsersonData() {
        var personData = PersonData()
        personData = inputDataToPersonData(db: personData!)
        try? realm?.write {
            realm?.add((personData)!)
        }
    }
    
    func inputDataToPersonData(db: PersonData) -> PersonData {
        if let name = inputUserName.text {
            db.userName = name
        }
        
        var age = 0
        if let getAge = inputUserAge.text {
            if getAge == "" }
            age = 0
        } else {
            age = Int(getAge)!
        }
        db.userAge = age
        
        if let email = inputUserEmail.text {
            db.userEmail = email
        }
        
        return db
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
