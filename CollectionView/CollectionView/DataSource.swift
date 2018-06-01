//
//  DataSource.swift
//  CollectionView
//
//  Created by Kim on 2018. 5. 29..
//  Copyright © 2018년 Kim. All rights reserved.
//

import Foundation

class DataSource {
    
    var programs: [Program] = []
    var groupHardDisk: [String] = []
    var groupMemory: [String] = []
    
    init() {
        populateData()
    }
    
    // 해당 세션의 셀들 반환
    func programsInGroup(index: Int) -> [Program] {
        let item = groupMemory[index]
        let filteredPrograms = programs.filter { (program: Program) -> Bool in
            return program.group == item
        }
        return filteredPrograms
    }
    
    // 셀의 수 반환
    func numberOfRowsInEachGroup(index: Int) -> Int {
        return programsInGroup(index: index).count
    }
    
    // 그룹의 수
    func numberOfGroups() -> Int {
        return groupMemory.count
    }
    
    // 헤더명 읽어오기
    func getGroupLabelAtIndex(index: Int) -> String {
        return groupHardDisk[index]
    }
    
    // 데이터 읽어오기
    func populateData() {
        if let path = Bundle.main.path(forResource: "programs", ofType: "plist") {
            if let dictArray = NSArray(contentsOfFile: path) {
                for item in dictArray {
                    if let dict = item as? NSDictionary {
                        let name = dict["name"] as! String
                        let group = dict["group"] as! String
                        
                        let program = Program(name: name, group: group)
                        if !groupHardDisk.contains(group) {
                            groupHardDisk.append(group)
                            groupMemory.append(group)
                        }
                        programs.append(program)
                    }
                }
            }
        }
    }
}
