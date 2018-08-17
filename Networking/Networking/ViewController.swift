//
//  ViewController.swift
//  Networking
//
//  Created by Jinu Kim on 2018. 8. 17..
//  Copyright © 2018년 Jinu Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var friends: [Friend] = []
    
    let cellIdentifier: String = "friendCell"

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        let friend: Friend = self.friends[indexPath.row]
        
        cell.textLabel?.text = friend.name.full
        cell.detailTextLabel?.text = friend.email
        cell.imageView?.image = nil
        
        DispatchQueue.global().async {
            
            guard let imageURL: URL = URL(string: friend.picture.thumbnail) else {
                return
            }
            
            guard let imageData = try? Data(contentsOf: imageURL) else {
                return
            }
            
            DispatchQueue.main.async {
                if let index: IndexPath = tableView.indexPath(for: cell) {
                    if index.row == indexPath.row {
                        cell.imageView?.image = UIImage(data: imageData)
                    }
                }
            }
        }
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didRecieveFriendsNotification(_:)), name: DidReceiveFriendsNotification, object: nil)
    }
    
    @objc func didRecieveFriendsNotification(_ noti: Notification) {
        
        guard let friends: [Friend] = noti.userInfo?["friends"] as? [Friend] else {
            return
        }
        
        self.friends = friends
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        requestFriends()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

