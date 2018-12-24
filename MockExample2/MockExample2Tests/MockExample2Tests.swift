//
//  MockExample2Tests.swift
//  MockExample2Tests
//
//  Created by Jinu Kim on 21/12/2018.
//  Copyright © 2018 GAMZA. All rights reserved.
//

import XCTest
@testable import MockExample2

class MockCook: CookProtocol {
    var cookRamenCallCount = 0
    var cookRamenLastBowls = 0
    var cookRamenLastSoup: RamenSoup?
    var cookRamenLastExtras: [String] = []
    
    func cookRamen(bowls: Int, soup: RamenSoup, extras: [String]) {
        cookRamenCallCount += 1
        cookRamenLastBowls = bowls
        cookRamenLastSoup = soup
        cookRamenLastExtras = extras
    }
    
    
//    func verifyCookRamen(bowls: Int, soup: RamenSoup, extras: [String], file: StaticString = #file, line: UInt = #line) -> Void {
//    =>
    func verifyCookRamen(bowls: Int, soup: RamenSoup, extrasMatcher: (([String]) -> Bool), file: StaticString = #file, line: UInt = #line) -> Void {
        XCTAssertEqual(1, cookRamenCallCount, "call count", file: file, line: line);
        XCTAssertEqual(bowls, cookRamenLastBowls, "bowls", file: file, line: line);
        XCTAssertEqual(soup, cookRamenLastSoup, "soup", file: file, line: line);
        XCTAssertTrue(extrasMatcher(cookRamenLastExtras), "extras was \(cookRamenLastExtras)", file: file, line: line)
    }
//    => Use Libary
//    func verifyCookRamenUsingHamcreset(bowls: Match<Int>, soup: Matcher<RamenSoup>, extras: Matcher<Array<String>>, file: StaticString = #file, line: UInt = #line) -> {
//        applyMatcher
//    }
//
//    func applyMatcher<T>(_ matcher: Matcher<T>, label: String, toValue value: T, _ file: StaticString, _ line: UInt) -> Void {
//        switch matcher.matches(value) {
//        case .match:
//            return
//        case let .mismatch(mismatchDescription):
//            XCTFail(label + " " + describeMismatch(value, matcher.description, mismatchDescription, file: file, line: line))
//        }
//    }
}

class WaiterTests: XCTestCase {
    
    func testOrder_ShouldCookRamen() {
        let mockCook = MockCook()
        let waiter = Waiter(cook: mockCook)
        
        waiter.order()
        
        //        XCTAssertEqual(cookRamenCallCount, 1)
        //        XCTAssertEqual(mockCook.cookRamenLastBowls, 2)
        //        XCTAssertEqual(mockCook.cookRamenLastSoup, RamenSoup.miso)
        //        XCTAssertEqual(mockCook.cookRamenLastExtras, ["wakame", "tamago"])
        //        =>
        mockCook.verifyCookRamen(bowls: 2, soup: .miso, extrasMatcher: { extras in
            return extras.count == 2 && extras.contains("tamago") && extras.contains("wakame")
        })
    }
    
    
//    func verifyCookRamen(bowls: Int, soup: RamenSoup, extras: [String]) files: StaticString = #file,
//    line: UInt = #line) -> Void {
//        XCA
//    }
}
