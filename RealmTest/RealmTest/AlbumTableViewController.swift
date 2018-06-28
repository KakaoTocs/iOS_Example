//
//  AlbumTableViewController.swift
//  RealmTest
//
//  Created by Kim on 2018. 6. 25..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit
import RealmSwift

class AlbumTableViewController: UITableViewController, UISearchBarDelegate {

    private let reuseIdentifier = "AlbumCell"
    var realm: Realm!
    var albums: Results<Album>!
    
    var token: NotificationToken!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Realm init
        do {
            realm = try! Realm()
        } catch {
            print("\(error)")
        }
        
        albums = realm.objects(Album.self).sorted(byKeyPath: "createDate", ascending: false)
        
        token = albums.observe({ (change) in
            self.tableView.reloadData()
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AlbumTableViewCell
        
        cell.titleLabel.text = albums[indexPath.row].title
        if let imageData = albums[indexPath.row].photos.sorted(byKeyPath: "createDate", ascending: false).first?.imageData {
            cell.thumnailView.image = UIImage(data: imageData, scale: 0.1)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (deleteAction, indexPath) in
            do {
                try self.realm.write {
                    self.realm.delete(self.albums[indexPath.row].photos)
                    self.realm.delete(self.albums[indexPath.row])
                }
            } catch {
                print("\(error)")
            }
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") {
            (UITableViewRowAction, indexPath) in
            self.alertForAlbumName(albumName: self.albums[indexPath.row])
        }
        return [deleteAction, editAction]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Photo" {
            if let photoCollectionVew = segue.destination as? PhotoCollectionViewController,
                let selectedPath = tableView.indexPathForSelectedRow {
                photoCollectionVew.selectedAlbum = albums[selectedPath.row]
            }
        }
    }
    
    @IBAction func addNewAlbum(_ sender: UIBarButtonItem) {
        alertForAlbumName(albumName: nil)
    }
    
    func alertForAlbumName(albumName: Album?) {
        let alertController = UIAlertController(title: "앨범명", message: "Insert Album Title", preferredStyle: .alert)
        alertController.addTextField { (UITextField) in
            if albumName != nil {
                UITextField.text = albumName?.title
            }
        }
        let cancleAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            let inputTitle = alertController.textFields?.first?.text
            if albumName != nil {
//                let newAlbum = Album()
//                newAlbum.title = (alertController.textFields?.first?.text)!
                
                do {
                    try self.realm.write {
                        albumName?.title = inputTitle!
                    }
                } catch {
                    print("\(error)")
                }
            } else {
                let newAlbum = Album()
                newAlbum.title = inputTitle!
                do {
                    try self.realm.write {
                        self.realm.add(newAlbum)
                    }
                } catch {
                    
                }
            }
        }
        
        alertController.addAction(cancleAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        albums = realm.objects(Album.self).filter("title contains[c]", searchText).sorted(byKeyPath: "createDate", ascending: false)
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true )
    }
}
