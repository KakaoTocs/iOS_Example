//
//  ViewController.swift
//  ImageCollection
//
//  Created by DGSW_TEACHER on 2018. 5. 28..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let dataModel = ["1.jpg", "2.png", "3.jpg", "4.jpg", "5.jpg", "6.jpg", "7.png", "8.png", "9.png", "10.jpg", "11.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
    }
}

extension ViewController: UICollectionViewDataSource, PinterestLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as? CustomCollectionViewCell {
            
            cell.imageView.image = UIImage(named: "Photo\(dataModel[indexPath.row])")
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 15
            cell.imageView.contentMode = .scaleAspectFill
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let image = UIImage(named: "Photo\(dataModel[indexPath.row])")
        
        if let height = image?.size.height {
            return height / 4.0
        }
        
        return 0.0
    }
}
