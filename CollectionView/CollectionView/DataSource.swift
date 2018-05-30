//
//  DataSource.swift
//  CollectionView
//
//  Created by Kim on 2018. 5. 29..
//  Copyright © 2018년 Kim. All rights reserved.
//

import Foundation

class DataSource {
    
    init() {
        populateData()
    }
    
    var programs: [Program] = []
    var groups: [String] = []
    
    func numberOfRowsInEachGroup(index: Int) -> Int {
        return programsInGroup(index: index).count
    }
    
    func numberOfGroups() -> Int {
        return groups.count
    }
    
    func getGroupLabelAtIndex(index: Int) -> String {
        return groups[index]
    }
    
    func populateData() {
        if let path = Bundle.main.path(forResource: "programs", ofType: "plist") {
            if let dictArray = NSArray(contentsOfFile: path) {
                for item in dictArray {
                    if let dict = item as? NSDictionary {
                        let name = dict["name"] as! String
                        let group = dict["group"] as! String
                        
                        let program = Program(name: name, group: group)
                        if !groups.contains(group) {
                            groups.append(group)
                        }
                        programs.append(program)
                    }
                }
            }
        }
    }
    
    func programsInGroup(index: Int) -> [Program] {
        let item = groups[index]
        let filteredPrograms = programs.filter { (program: Program) -> Bool in
            return program.group == item
        }
        return filteredPrograms
    }
}
