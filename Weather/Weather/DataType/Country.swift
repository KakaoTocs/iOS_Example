//
//  Country.swift
//  Weather
//
//  Created by Kim on 2018. 6. 4..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import Foundation

class Country {
    let name: String
    var cities: [City] = []
    let assetName: String
    var flagName: String {
        get {
            return "flag_\(self.assetName)"
        }
    }
    
    init(countryName: String, assetName: String) {
        self.name = countryName
        self.assetName = assetName
    }
}

struct CountryJSON: Codable {
    let korean_name: String
    let asset_name: String
}
