//
//  DataType.swift
//  RealmTest
//
//  Created by Kim on 2018. 6. 25..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import Foundation
import RealmSwift

class Album: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var createDate: Date = Date()
    @objc dynamic var uuid: String = UUID().uuidString
    let photos: List<Photo> = List<Photo>()
    
//    override class func primaryKey() -> String? {
//        return "uuid"
//    }
}

class Photo: Object {
    @objc dynamic var createDate: Date = Date()
    @objc dynamic var imageData: Data = Data()
}
