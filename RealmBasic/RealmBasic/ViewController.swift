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
//    var token: NotificationToken!

    @IBOutlet weak var dogNameTextField: UITextField!
    @IBOutlet weak var dogAgeTextField: UITextField!
    
//    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            realm = try! Realm()
        } catch {
            print("\(error)")
        }
        
        dogs = realm.objects(Dog.self).sorted(byKeyPath: "createData", ascending: false)
        
//        token = dogs?.observe({ (change) in
//            self.tableView.reloadData()
//        })
        
        /*
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
        */
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dogs.count
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
        
        if let dog: Dog = dogs[indexPath.row] {
            cell.textLabel?.text = dog.name
        }
        
        return cell
    }
    
    @IBAction func addDataAction(_ sender: UIButton) {
        if let name = dogNameTextField.text, let stringAge = dogAgeTextField.text, let age = Int(stringAge) {
            do {
                let newDog = Dog()
                newDog.name = name
                newDog.age = age
                try self.realm.write {
                    self.realm.add(newDog)
                }
            } catch {
                print("\(error)")
            }
        } else {
            print("Name read error!")
        }
    }
    
    @IBAction func deleteDataAction(_ sender: UIButton) {
        if let name = dogNameTextField.text {
            print("Hello")
        }
    }
    
}

