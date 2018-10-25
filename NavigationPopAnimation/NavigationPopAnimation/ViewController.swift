//
//  ViewController.swift
//  NavigationPopAnimation
//
//  Created by Jinu Kim on 24/10/2018.
//  Copyright © 2018 Jinu Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var selectedFrame: CGRect?
    private var customInteractor: CustomInteractor?
    private var selectedImageName: String?
    
    private var images = ["photo1.jpg", "photo2.jpg", "photo3.jpg", "photo4.jpg"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.delegate = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.imageName = self.selectedImageName
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let ci = customInteractor else { return nil }
        return ci.transitionInProgress ? customInteractor : nil
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let frame = self.selectedFrame else { return nil }
        guard let image = self.selectedImageName  else { return nil }
        
        switch operation {
        case .push:
            self.customInteractor = CustomInteractor(attachTo: toVC)
            return CustomAnimator(duration: TimeInterval(UINavigationController.hideShowBarDuration), isPresenting: true, originFrame: frame, image: UIImage(named: image)!)
        default:
            return CustomAnimator(duration: TimeInterval(UINavigationController.hideShowBarDuration), isPresenting: false, originFrame: frame, image: UIImage(named: image)!)
        }
    }

}

// CollectionView Delegate코드
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.imageView.image = UIImage(named: images[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width / 2, height: self.collectionView.frame.width / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedImageName = images[indexPath.item]
        let theAttributes:UICollectionViewLayoutAttributes! = collectionView.layoutAttributesForItem(at: indexPath)
        selectedFrame = collectionView.convert(theAttributes.frame, to: collectionView.superview)
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }
}
