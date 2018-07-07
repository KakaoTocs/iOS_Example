//
//  DataType.swift
//  RealmBasic
//
//  Created by user on 07/07/2018.
//  Copyright © 2018 KakaoTocs. All rights reserved.
//

import Foundation
import RealmSwift

class Dog: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
}

class Person: Object {
    @objc dynamic var name = ""
    @objc dynamic var picture: Data? = nil
    let dogs = List<Dog>()
}
