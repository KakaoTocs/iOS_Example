//
//  ViewController.swift
//  RealmBasic
//
//  Created by user on 06/07/2018.
//  Copyright © 2018 KakaoTocs. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var inputUserName: UITextField!
    @IBOutlet weak var inputUserAge: UITextField!
    @IBOutlet weak var inputUserEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myDog = Dog()
        myDog.name = "Rex"
        myDog.age = 1
        print("Dog name: \(myDog.name)")
        
        let realm = try! Realm()
        
        let puppies = realm.objects(Dog.self).filter("age < 2")
        print(puppies.count)
        
        try! realm.write {
            realm.add(myDog)
        }
        
        print(puppies.count)
        
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                let theDog = realm.objects(Dog.self).filter("age == 1").first
                try! realm.write {
                    theDog!.age = 3
                }
            }
        }
    }
}

