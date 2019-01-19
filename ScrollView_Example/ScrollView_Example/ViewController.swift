//
//  ViewController.swift
//  ScrollView_Example
//
//  Created by Jinu Kim on 09/01/2019.
//  Copyright © 2019 com.kakaotocs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gridView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        
        // ScrollView 초기화
        self.scrollView.delegate = self
        self.imageView.contentMode = .scaleAspectFill
        self.gridView.backgroundColor = UIColor.brown.withAlphaComponent(0.6)
        
        // Log
        print("- Screen: \(UIScreen.main.bounds)")
        print("- Screen Width: \(UIScreen.main.bounds.width - 40) Hight: \(UIScreen.main.bounds.height - 40)")
        print("-----------------------------------------------")
        print("|C1 - Scroll Offset: \(scrollView.contentOffset)")
        print("|C2 - Scroll Inset: \(scrollView.contentInset)")
        print("|N1 - Scroll Bounds: \(scrollView.bounds)")
        print("|N2 - Scroll Frame: \(scrollView.frame)")
        print("-----------------------------------------------")
        
        // 비율
        let scaleH = gridView.frame.size.height / imageView.frame.height
        // 실제 이미지 가로 크기
        let imageViewWidth = imageView.image?.size.width ?? 0
        // 비율 적용된 이미지
        let scaledImageWidth = imageViewWidth * scaleH
        print("GridView Width: \(gridView.frame.width)")
        // ScrollView에 보이는 콘텐츠의 크기
        print("Contents Size: \(scrollView.contentSize)")
        // 가로 여백
        let width = (scaledImageWidth - gridView.frame.width) / 2// + 20
        // 이미지 크기에 비율 적용 식
        print("Six_Image with Scale \(imageView.image?.size.width ?? 0) * \(scaleH)")
        // 화면에서 잘리는 여백 가로 구하는 식
        print("Six_Temp width (\(scaledImageWidth) - \(UIScreen.main.bounds.width)) / 2 + 20 = \(width)")
        // 비율
        print("ScaleH: \(scaleH)")
        // ScrollView에 비율 적용
        self.scrollView.minimumZoomScale = 0.9// scaleH
        self.scrollView.maximumZoomScale = 2.0
        self.scrollView.zoomScale = 0.9//scaleH
        // ScrollView의 콘텐츠 크기랑 GridView의 크기랑 같은지 확인
        print("(Scroll Size)\(scrollView.contentSize) == (Grid Size)\(gridView.frame.size)")
        
        // GrideView의 시작 위치
        let temp = gridView.frame.minY
        print("Temp: \(temp)")
        
        // 확대 했을떄 더 보이게
        self.scrollView.contentInset = .init(top: temp, left: width, bottom: temp, right: width)
        
        // ScrollView의 세로 높이가 gridView보다 커서 최소 스케일로 설정해도 벗어나 있는 문제 해결 해야됨
        // Scale로 이미지 곱해서 확인하기
        // 보여지는 위치 시작점 설정
        scrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: false)
        
        print("ImageOriginal: \(imageView.image?.size)")
        print("ContentSize: \(scrollView.contentSize)")
        print("Scroll Inset: \(scrollView.contentInset)")
        print("Grid: \(gridView.bounds.size)")
    
        self.scrollView.clipsToBounds = true
        print(scrollView.subviews.first?.bounds)
        
        print("|Changed - Image Size: \(imageView.image?.size)")
        print("-----------------------------------------------")
        print("|C1 - Scroll Offset: \(scrollView.contentOffset)")
        print("|C2 - Scroll Inset: \(scrollView.contentInset)")
        print("|N1 - Scroll Bounds: \(scrollView.bounds)")
        print("|N2 - Scroll Frame: \(scrollView.frame)")
        print("-----------------------------------------------")
        print("Same \(gridView.frame) : \(scrollView.contentSize) : \(scrollView.contentInset) : \(scrollView.contentOffset)")
        self.view.layoutIfNeeded()
        
        print("Scaled: \(width)")
        
        print("ScaledImageWidth: \(scaledImageWidth)")
        
        gridViewSetting()
//        scrollViewSetting()
    }
    
    private func gridViewSetting() {
//        self.gridView.layer.borderColor = UIColor.black.cgColor
//        self.gridView.layer.borderWidth = 1
    }
}

extension ViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        
//        let widthTemp = (imageView.image!.size.width - scrollView.bounds.width) / 2
//        let heightTemp = (imageView.image!.size.height - scrollView.bounds.height) / 2
//
//        print("widthTemp: \(widthTemp)")
//        print("heightTemp: \(heightTemp)")
    }
}
