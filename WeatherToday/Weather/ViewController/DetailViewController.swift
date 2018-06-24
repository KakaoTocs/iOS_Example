//
//  WeatherViewController.swift
//  Weather
//
//  Created by DGSW_TEACHER on 2018. 4. 26..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var weatherIconView: UIImageView!
    @IBOutlet weak var weatherNameLable: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var rainFallLabel: UILabel!
    
    // MARK: - Property
//    var city: City?
    var city: CityJSON?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let cityData = city {
            // 도시명
            self.title = cityData.cityName!
            // 날씨 이름
            weatherNameLable.text = cityData.weatherName
            // 온도
            temperatureLabel.text = "섭씨 \(cityData.celsius)도 / 화씨 \(cityData.fahrenheit)도"
            temperatureLabel.textColor = cityData.temperatureColor
            // 강수확률
            rainFallLabel.text = "강수확률 \(cityData.rainfallProbability)%"
            rainFallLabel.textColor = cityData.rainFallColor
            // 날씨 아이콘
            if let weather = cityData.weatherIcon {
                weatherIconView.image = UIImage(named: weather)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
