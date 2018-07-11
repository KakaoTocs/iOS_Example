//
//  ViewController.swift
//  RealmBasic
//
//  Created by user on 11/07/2018.
//  Copyright © 2018 KakaoTocs. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var realm: Realm!
    var dogs: Results<Dog>!
    
    var token: NotificationToken!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            realm = try! Realm()
        } catch {
            print("\(error)")
        }
        
        dogs = realm.objects(Dog.self).sorted(byKeyPath: "name", ascending: false)
        
        token = dogs.observe({ (change) in
            print("change: \(change)")
            self.tableView.reloadData()
        })
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
        
        if let dog: Dog = dogs[indexPath.row] {
            cell.textLabel?.text = dog.name
            cell.detailTextLabel?.text = String(dog.age)
        }
        
        return cell
    }

    /// 오류타입 열거형
    ///
    /// - Parameter sender: <#sender description#>
    @IBAction func dogAddButton(_ sender: UIButton) {
        if let name = nameTextField.text, let stringAge = ageTextField.text, let age = Int(stringAge) {
            do {
                let newDog = Dog()
                newDog.name = name
                newDog.age = age
                
                try self.realm.write {
                    self.realm.add(newDog)
                }
            } catch {
                print("Name read error!")
            }
        }
    }
    
    @IBAction func dogDeleteButton(_ sender: UIButton) {
        if let name = nameTextField.text {
            print("Hello")
        }
    }
}

