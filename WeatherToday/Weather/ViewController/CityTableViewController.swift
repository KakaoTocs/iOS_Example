//
//  CityTableViewController.swift
//  Weather
//
//  Created by DGSW_TEACHER on 2018. 4. 26..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit

class CityTableViewController: UITableViewController {
    
    // MARK: - Property
    var cities: [City] = []

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
        // return country?.cities.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as? CityTableCell else{
            return UITableViewCell()
        }
        // 해당 셀 인덱스의 도시
        let city = cities[indexPath.row]
        // 도시 이름
        cell.cityNameLabel.text = city.cityName
        if let celsius = city.celsius,
            let fahrenheit = city.fahrenheit,
            let rainFall = city.rainfallProbability,
            let weatherIconName = city.weatherIcon{
            // 온도
            cell.temperatureLabel.text = "섭씨 \(celsius)도 / 화씨 \(fahrenheit)도"
            cell.temperatureLabel.textColor = city.temperatureColor
            // 강수확률
            cell.rainFallLabel.text = "강수확률 \(rainFall)%"
            cell.rainFallLabel.textColor = city.rainFallColor
            // 날씨 아이콘
            cell.weatherImage.image = UIImage(named: weatherIconName)
        }
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "weatherDetailSegue" {
            if let detailViewController = segue.destination as? DetailViewController,
                let selectedPath = tableView.indexPathForSelectedRow {
                // 선택된 도시 정보 전달
                detailViewController.city = self.cities[selectedPath.row]
            }
        }
    }
}
