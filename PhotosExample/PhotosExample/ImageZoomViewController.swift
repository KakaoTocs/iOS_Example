//
//  ImageZoomViewController.swift
//  PhotosExample
//
//  Created by DGSW_TEACHER on 2018. 5. 2..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit
import Photos

class ImageZoomViewController: UIViewController , UIScrollViewDelegate{
    
    var asset: PHAsset!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    
    @IBOutlet weak var imageView: UIImageView!
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        imageManager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
            self.imageView.image = image
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
