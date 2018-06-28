//
//  PhotoCollectionViewController.swift
//  RealmTest
//
//  Created by Kim on 2018. 6. 25..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit
import RealmSwift

class PhotoCollectionViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    var selectedAlbum: Album!
    
    private let reuseIdentifier = "PhotoCell"
    private var realm: Realm!
    private var photos: Results<Photo>?
    private var token: NotificationToken!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            realm = try Realm()
        } catch {
            print("\(error)")
        }
        
        photos = selectedAlbum.photos.sorted(byKeyPath: "createDate", ascending: false)
        token = photos?.observe({ (change) in
            self.collectionView?.reloadData()
        })
        
        navigationItem.title = selectedAlbum.title
        
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return (photos?.count)!
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        
        if let image = UIImage(data: photos![indexPath.item].imageData) {
            cell.imageView.image = image
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDeleteAlert(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemLength = (collectionView.frame.size.width - 15) / 4
        return CGSize(width: itemLength, height: itemLength)
    }
    
    @IBAction func showImagePicker(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let newPhoto = Photo()
        newPhoto.imageData = UIImageJPEGRepresentation(selectedImage, 0.01)!
        
        do {
            try realm.write {
                self.selectedAlbum.photos.append(newPhoto)
            }
        } catch {
            print("\(error)")
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImage(_ sender: UIBarButtonItem) {
        let imagePickerView = UIImagePickerController()
        imagePickerView.delegate = self
        imagePickerView.sourceType = .photoLibrary
        self.present(imagePickerView, animated: true) {}
    }
    
    func showDeleteAlert(indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Delete", message: "", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (deleteAction) in
            do {
                try self.realm.write {
                    self.realm.delete(self.photos![indexPath.item])
                }
            } catch {
                print("\(error)")
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
//    func alertToDelete(selectedIndexPath: IndexPath) {
//        
//    }

}
