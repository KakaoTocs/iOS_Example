//
//  ViewController.swift
//  TDD
//
//  Created by Jinu Kim on 27/11/2018.
//  Copyright © 2018 Jinu Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var likeCount = 0
    
    let _likeButton = likeButton
    let _likeResetButton = likeResetButton
    let _likeDescriptionLabel = likeDescriptionLabel
    
    func setupUIAndPosition() {
        let viewCenterX = view.center.x
        let viewCenterY = view.center.y
        
        _likeButton.center = CGPoint(x: viewCenterX, y: viewCenterY + 50)
        _likeDescriptionLabel.center = CGPoint(x: viewCenterX, y: viewCenterY + -50)
        _likeResetButton.center = CGPoint(x: viewCenterX, y: viewCenterY + 120)
        
        _likeButton.addTarget(self, action: #selector(didTabLikeButton), for: .touchUpInside)
        _likeResetButton.addTarget(self, action: #selector(didTabResetLikeButton), for: .touchUpInside)
    }
    
    @objc func didTabLikeButton() {
        editLikeDescriptionLabelBasedOnLikeCount(likeCount: &likeCount)
    }
    
    @objc func didTabResetLikeButton() {
        resetLikeCount(likeCount: &likeCount)
    }
    
    func addSubview() {
        view.addSubview(_likeButton)
        view.addSubview(_likeResetButton)
        view.addSubview(_likeDescriptionLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIAndPosition()
        addSubview()
    }

    
    func editLikeDescriptionLabelBasedOnLikeCount(likeCount: inout Int) {
        likeCount += 1
        _likeDescriptionLabel.text = "\(likeCount)명이 좋아합니다"
    }
    
    func resetLikeCount(likeCount: inout Int) {
        likeCount = 0
        _likeDescriptionLabel.text = "0명이 좋아합니다"
    }

}

