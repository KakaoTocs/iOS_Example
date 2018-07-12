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
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        do {
            realm = try! Realm()
        } catch {
            print("\(error)")
        }
        
        dogs = realm.objects(Dog.self).sorted(byKeyPath: "name", ascending: false)
        print(dogs.count)
        token = dogs.observe({ (change) in
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
            print(dogs)
            cell.textLabel?.text = dog.name
            cell.detailTextLabel?.text = String(dog.age)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (deleteAction, indexPath) in
            do {
                try self.realm.write {
                    self.realm.delete(self.dogs[indexPath.row])
                }
            } catch {
                print("\(error)")
            }
        }
        
        return [deleteAction]
    }

    @IBAction func dogAddButton(_ sender: UIButton) {
        if let name = nameTextField.text, let stringAge = ageTextField.text, let age = Int(stringAge) {
            do {
                let newDog = Dog(name: name, age: age)
                
                try self.realm.write {
                    self.realm.add(newDog)
                }
            } catch {
                print("Name read error!")
            }
        }
    }
    
    @IBAction func dogDeleteButton(_ sender: UIButton) {
        if let name = nameTextField.text, let stringAge = ageTextField.text, let age = Int(stringAge) {
            let targetDog = Dog(name: name, age: age)
            let index = dogs.index(of: targetDog)
            do {
                try self.realm.write {
                    self.realm.delete(self.dogs[index!])
                }
            } catch {
                print("\(error)")
            }
        }
    }
}

