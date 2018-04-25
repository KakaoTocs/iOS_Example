//
//  TreeViewData.swift
//  TreeTableView
//
//  Created by DGSW_TEACHER on 2018. 4. 25..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

class TreeViewData {
    var level: Int
    var name: String
    var id: String
    var parentId: String
    
    init?(level: Int, name: String, id: String, parentId: String) {
        self.level = level
        self.name = name
        self.id = id
        self.parentId = parentId
    }
}
