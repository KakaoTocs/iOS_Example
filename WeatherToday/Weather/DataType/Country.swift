//
//  Country.swift
//  Weather
//
//  Created by Kim on 2018. 6. 4..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import Foundation

struct Country: Codable {
    // 국가명
    let koreanName: String?
    // 국가의 도시 에셋 파일명
    let assetName: String?
    // 국기 파일 이름
    var flagName: String? {
        get {
            if let countryAssetName = self.assetName {
                return "flag_\(countryAssetName)"
            } else {
                return nil
            }
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case koreanName = "korean_name"
        case assetName = "asset_name"
    }
}
