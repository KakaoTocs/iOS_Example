//
//  TDDTests.swift
//  TDDTests
//
//  Created by Jinu Kim on 06/12/2018.
//  Copyright © 2018 Jinu Kim. All rights reserved.
//

import XCTest
@testable import TDD

class TDDTests: XCTestCase {
    
    let sut = ViewController()
    
    // setup / tearDown 테스트 메소드의 호출 전/후에 한번 호출
    // 초기화 코드
    override func setUp() {
        _ = sut.view
    }
    
    // 해체 코드
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
