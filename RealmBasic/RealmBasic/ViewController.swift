//
//  ViewController.swift
//  RealmBasic
//
//  Created by user on 06/07/2018.
//  Copyright © 2018 KakaoTocs. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UITableViewController {
    
    var realm: Realm!
    var dogs: Results<Dog>!
    var token: NotificationToken!

    @IBOutlet weak var dogNameTextField: UITextField!
    @IBOutlet weak var dogAgeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            realm = try! Realm()
        } catch {
            print("\(error)")
        }
        
        dogs = realm.objects(Dog.self).sorted(byKeyPath: "createData", ascending: false)
        
            
//        albums = realm.objects(Album.self).sorted(byKeyPath: "createDate", ascending: false)
//        
//        token = albums.observe({ (change) in
//            self.tableView.reloadData()
//        })
        
        let myDog = Dog()
        myDog.name = "Rex"
        myDog.age = 1
        print("Dog name: \(myDog.name)")
        
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
    
    @IBAction func addDataAction(_ sender: UIButton) {
        
    }
    
    @IBAction func deleteDataAction(_ sender: UIButton) {
    }
    
}

