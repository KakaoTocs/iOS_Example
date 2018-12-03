//
//  View.swift
//  TDD
//
//  Created by Jinu Kim on 03/12/2018.
//  Copyright © 2018 Jinu Kim. All rights reserved.
//

import UIKit

let likeButton: UIButton = {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
    button.backgroundColor = UIColor(
        displayP3Red: 59/255,
        green: 89/255,
        blue: 152/255,
        alpha: 1
    )
    button.clipsToBounds = true
    button.layer.cornerRadius = 5
    button.setTitle("좋아요", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont(name: "Helvetica", size: 25)
    return button
}()

let likeResetButton: UIButton = {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
    button.setTitleColor(.darkGray, for: .normal)
    button.setTitle("초기화", for: .normal)
    button.titleLabel?.font = UIFont(name: "Helvetica", size: 16)
    return button
}()

let likeDescriptionLabel: UILabel = {
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
    label.text = "0명이 좋아합니다"
    label.font = UIFont(name: "Helvetica", size: 30)
    label.textAlignment = .center
    return label
}()
