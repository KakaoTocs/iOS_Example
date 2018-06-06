//
//  Country.swift
//  Weather
//
//  Created by DGSW_TEACHER on 2018. 4. 26..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit

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

struct CityJSON: Codable {
    let city_name: String
    let state: Int
    let celsius: Double
    let rainfall_probability: Int
}
