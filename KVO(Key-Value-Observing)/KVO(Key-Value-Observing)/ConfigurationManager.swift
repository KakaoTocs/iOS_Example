//
//  ConfigurationManager.swift
//  KVO(Key-Value-Observing)
//
//  Created by Jinu Kim on 06/01/2019.
//  Copyright © 2019 com.kakaotocs. All rights reserved.
//

import Foundation

class ConfigurationManager {
    var configuration: Configuration
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy:MM:dd HH:mm:ss"
        return dateFormatter
    }()
    
    var createdAt: String {
        return dateFormatter.string(from: configuration.createdAt)
    }
    
    var updatedAt: String {
        return dateFormatter.string(from: configuration.updatedAt)
    }
    
    init(withConfiguration configuration: Configuration) {
        self.configuration = configuration
    }
    
    func updateConfiguration() {
        configuration.updatedAt = Date()
    }
}
