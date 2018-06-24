//
//  Country.swift
//  Weather
//
//  Created by DGSW_TEACHER on 2018. 4. 26..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit
/*
class City {
    let name: String
    let state: Int
    let rainfall: Int
    let celsius: Double
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
    var fahrenheit: Double {
        get {
            return ((32 + 1.8 * self.celsius) * 10).rounded() / 10
        }
    }
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
    var temperatureColor: UIColor {
        get {
            if self.celsius <= 10.0 {
                return UIColor.blue
            } else if self.celsius >= 25.0 {
                return UIColor.red
            } else {
                return UIColor.black
            }
        }
    }
    var rainFallColor: UIColor {
        get {
            if self.rainfall >= 60 {
                return UIColor.orange
            } else {
                // 셀 재사용 -> 필수
                return UIColor.black
            }
        }
    }
    
    init(name: String, state: Int, rainfall: Int, celsius: Double) {
        self.name = name
        self.state = state
        self.rainfall = rainfall
        self.celsius = celsius
    }
}
*/
struct CityJSON: Codable {
    let cityName: String?
    let state: Int?
    let celsius: Double?
    let rainfallProbability: Int?
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
    var fahrenheit: Double? {
        get {
            if let celsius = self.celsius {
                return ((32 + 1.8 * celsius) * 10).rounded() / 10
            } else {
                return nil
            }
        }
    }
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
