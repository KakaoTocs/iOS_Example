//
//  TDDTests.swift
//  TDDTests
//
//  Created by Jinu Kim on 27/11/2018.
//  Copyright © 2018 Jinu Kim. All rights reserved.
//

import XCTest
@testable import TDD

class TDDTests: XCTestCase {
    
    let sut = ViewController()
    
    override func setUp() {
        _ = sut.view
    }
    
    // 함수 끝나고 항상 실행
    override func tearDown() {
        sut.likeCount = 0
    }
    
    func test_buttons_and_label_exist() {
        XCTAssertEqual(sut._likeDescriptionLabel.text!, "0명이 좋아합니다")
        XCTAssertEqual(sut._likeResetButton.currentTitle!, "초기화")
        XCTAssertEqual(sut._likeButton.currentTitle!, "좋아요")
    }
    
    func testIncreaseLikeCount_when_likeButton_Pressed() {
        sut._likeButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut._likeDescriptionLabel.text!, "1명이 좋아합니다")
        XCTAssertEqual(sut.likeCount, 1)
    }
    
    func test_reset_likeCount_when_resetLikeButton_pressed() {
        let randomNumber = 123
        sut.likeCount = randomNumber
        sut._likeResetButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut._likeDescriptionLabel.text!, "0명이 좋아합니다")
        XCTAssertEqual(sut.likeCount, 0)
    }
}
