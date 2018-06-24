//
//  Country.swift
//  Weather
//
//  Created by Kim on 2018. 6. 4..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import Foundation
/*
class Country {
//    국가명
    let name: String
//    도시 정보
    var cities: [City] = []
//
    let assetName: String
//    국기 이미지명
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
*/
struct CountryJSON: Codable {
    let koreanName: String?
    let assetName: String?
    var flagName: String? {
        get {
            if let countryAssetName = self.assetName {
                return "flag_\(countryAssetName)"
            } else {
                return nil
            }
        }
    }
    // 옵셔널 바인딩 철저히!!
    enum CodingKeys: String, CodingKey {
        case koreanName = "korean_name"
        case assetName = "asset_name"
    }
}
