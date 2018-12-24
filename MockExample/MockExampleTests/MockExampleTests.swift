//
//  MockExampleTests.swift
//  MockExampleTests
//
//  Created by Jinu Kim on 20/12/2018.
//  Copyright © 2018 GAMZA. All rights reserved.
//

import XCTest
@testable import MockExample

class MockExampleTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchCharacters_ShouldMakeDataTaskForMarvelEndpoint() {
        let mockURLSession = MockURLSession()
        let sut = FetchCharactersMarvelService(session: mockURLSession)
        let reqquestModel = FetchCharactersRequestModel(namePrefix: "DUMMY", pageSize: 10, offset: 30)
        
        sut.fetchCharacters(requestModel: requestModel)
        
        XCTAssertEqual(mockURLSession.dataTaskWasCalled, 1)
        XCTAssertEqual(mockURLSession.dataTaskLastURL?.host, "gateway.marvel.com")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
