//
//  DataType.swift
//  RealmTest
//
//  Created by user on 06/07/2018.
//  Copyright © 2018 KakaoTocs. All rights reserved.
//

import Foundation
import RealmSwift

class PersonData: Object {
    @objc dynamic var userName = ""
    @objc dynamic var userAge = 0
    @objc dynamic var userEmail = ""
}
