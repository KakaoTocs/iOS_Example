//
//  TypeConvert.swift
//  SocketStream
//
//  Created by DGSW_TEACHER on 2018. 5. 26..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import Foundation

typealias Byte = UInt8

func toByteArray<T>(_ data: T) -> [Byte] {
    var value = data
    return withUnsafeBytes(of: &value) {
        Array($0)
    }
}

func fromByteArray<T>(_ value: [Byte], _: T.Type) -> T {
    return value.withUnsafeBytes {
        $0.baseAddress!.load(as: T.self)
    }
}

func mergeArray(data: [Byte]...) -> [Byte] {
    var result: [Byte] = []
    for value in data {
        for index in value {
            result.append(index)
        }
    }
    return result
}
