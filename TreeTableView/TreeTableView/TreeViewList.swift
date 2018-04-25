//
//  TreeViewList.swift
//  TreeTableView
//
//  Created by DGSW_TEACHER on 2018. 4. 25..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

class TreeViewList {
    
    static func LoadInitialData() -> [TreeViewData] {
        var data: [TreeViewData] = []
        data.append(TreeViewData(level: 0, name: "cindy's family tree", id: "1", parentId: "-1")!)
        data.append(TreeViewData(level: 0, name: "jack's family tree", id: "2", parentId: "-1")!)
        data.append(TreeViewData(level: 1, name: "katherine", id: "3", parentId: "1")!)
        data.append(TreeViewData(level: 1, name: "kyle", id: "4", parentId: "1")!)
        data.append(TreeViewData(level: 2, name: "hayley", id: "5", parentId: "3")!)
        data.append(TreeViewData(level: 2, name: "macey", id: "5", parentId: "3")!)
        data.append(TreeViewData(level: 1, name: "katelyn", id: "7", parentId: "2")!)
        data.append(TreeViewData(level: 1, name: "jared", id: "8", parentId: "2")!)
        data.append(TreeViewData(level: 1, name: "denyee", id: "9", parentId: "2")!)
        data.append(TreeViewData(level: 2, name: "cayleb", id: "10", parentId: "4")!)
        data.append(TreeViewData(level: 2, name: "carter", id: "11", parentId: "4")!)
        data.append(TreeViewData(level: 2, name: "braylon", id: "12", parentId: "4")!)
        data.append(TreeViewData(level: 3, name: "samson", id: "13", parentId: "5")!)
        data.append(TreeViewData(level: 3, name: "samson", id: "14", parentId: "6")!)
        
        return data
    }
    
    static func LoadInitialNodes(dataList: [TreeViewData]) -> [TreeViewNode] {
        var nodes: [TreeViewNode] = []
        
        for data in dataList where data.level == 0 {
            print("\(data.name)")
            
            let node: TreeViewNode = TreeViewNode()
            node.nodeLevel = data.level
            node.nodeObject = data.name as AnyObject
            node.isExpanded = GlobalVariables.TRUE
            
            let newLevel = data.level + 1
            node.nodeChildren = LoadChildrenNodes(dataList: dataList, level: newLevel, parentId: data.id)
            
            if node.nodeChildren?.count == 0 {
                node.nodeChildren = nil
            }
            
            nodes.append(node)
        }
        
        return nodes
    }
    
    static func LoadChildrenNodes(dataList: [TreeViewData], level: Int, parentId: String) -> [TreeViewNode] {
        var nodes: [TreeViewNode] = []
        
        for data in dataList where data.level == level && data.parentId == parentId {
            print("\(data.name)")
            
            let node: TreeViewNode = TreeViewNode()
            node.nodeLevel = data.level
            node.nodeObject = data.name as AnyObject
            node.isExpanded = GlobalVariables.FALSE
            
            let newLevel = level + 1
            node.nodeChildren = LoadChildrenNodes(dataList: dataList, level: newLevel, parentId: data.id)
            
            if node.nodeChildren?.count == 0 {
                node.nodeChildren = nil
            }
            
            nodes.append(node)
        }
        
        return nodes
    }
}
