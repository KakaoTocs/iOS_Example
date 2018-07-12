//
//  DataType.swift
//  RealmBasic
//
//  Created by user on 11/07/2018.
//  Copyright © 2018 KakaoTocs. All rights reserved.
//

import RealmSwift

/// 강아지 클래스
/// - name: 강아지의 이름
/// - age: 강아지의 나이
/// Default value: name = "", age = 0
class Dog: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    
    convenience init(name: String, age: Int) {
        self.init()
        self.name = name
        self.age = age
    }
}

class Person: Object {
    @objc dynamic var anme = ""
    @objc dynamic var picture: Data? = nil
    let dogs = List<Dog>()
}
