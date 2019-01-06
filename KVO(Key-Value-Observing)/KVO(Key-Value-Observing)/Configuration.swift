//
//  Model.swift
//  KVO(Key-Value-Observing)
//
//  Created by Jinu Kim on 06/01/2019.
//  Copyright © 2019 com.kakaotocs. All rights reserved.
//

import Foundation

@objcMembers class Configuration: NSObject {
    dynamic var createdAt: Date
    dynamic var updatedAt: Date
    
    init(createdAt: Date, updatedAt: Date) {
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
