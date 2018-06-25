//
//  Country.swift
//  Weather
//
//  Created by DGSW_TEACHER on 2018. 4. 26..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit

struct City: Codable {
    // 도시명
    let cityName: String?
    // 날씨
    let state: Int?
    // 강수량
    let rainfallProbability: Int?
    // 섭씨
    let celsius: Double?
    // 화씨
    var fahrenheit: Double? {
        get {
            if let celsius = self.celsius {
                return ((32 + 1.8 * celsius) * 10).rounded() / 10
            } else {
                return nil
            }
        }
    }
    // 날씨 아이콘명
    var weatherIcon: String? {
        get {
            switch self.state {
            case 10:
                return "sunny"
            case 11:
                return "cloudy"
            case 12:
                return "rainy"
            case 13:
                return "snowy"
            default:
                return nil
            }
        }
    }
    // 날씨명
    var weatherName: String {
        get {
            switch self.state {
            case 10:
                return "맑음"
            case 11:
                return "구름"
            case 12:
                return "비"
            case 13:
                return "눈"
            default:
                return "날씨 정보 없음"
            }
        }
    }
    // 온도 색상
    var temperatureColor: UIColor {
        get {
            if self.celsius! <= 10.0 {
                return UIColor.blue
            } else if self.celsius! >= 25.0 {
                return UIColor.red
            } else {
                return UIColor.black
            }
        }
    }
    // 강수량 색상
    var rainFallColor: UIColor {
        get {
            if self.rainfallProbability! >= 60 {
                return UIColor.orange
            } else {
                // 셀 재사용 -> 필수
                return UIColor.black
            }
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
        case state
        case celsius
        case rainfallProbability = "rainfall_probability"
    }
}
