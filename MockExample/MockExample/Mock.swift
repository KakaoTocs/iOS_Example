//
//  Mock.swift
//  MockExample
//
//  Created by Jinu Kim on 20/12/2018.
//  Copyright © 2018 GAMZA. All rights reserved.
//

import Foundation

protocol  URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

struct FetchCharactersMarvelService {
    init(session: URLSessionProtocol) {
        
    }
}


class MockURLSession: URLSessionProtocol {
    var dataTaskWasCalled = 0
    var dataTaskLastURL: URL?
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTaskWasCalled += 1
        dataTaskLastURL = url
        return URLSessionDataTask()
    }
}
