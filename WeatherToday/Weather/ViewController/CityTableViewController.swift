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
//    var country: Country?
    var cities: [CityJSON]?

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
        return cities?.count ?? 0
        /*
        if let count = {
            return count
        } else {
            return 0
        }
         */
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as? CityTableCell else{
            return UITableViewCell()
        }

        if let city = cities?[indexPath.row] {
            // 도시 이름
            cell.cityNameLabel.text = city.cityName
            // 온도
            cell.temperatureLabel.text = "섭씨 \(city.celsius)도 / 화씨 \(city.fahrenheit)도"
            cell.temperatureLabel.textColor = city.temperatureColor
            // 강수확률
            cell.rainFallLabel.text = "강수확률 \(city.rainfallProbability)%"
            cell.rainFallLabel.textColor = city.rainFallColor
            // 날씨 아이콘
            if let weather = city.weatherIcon {
                cell.weatherImage.image = UIImage(named: weather)
            }
        }
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "weatherDetailSegue" {
            if let detailViewController = segue.destination as? DetailViewController,
                let selectedPath = tableView.indexPathForSelectedRow {
                detailViewController.city = self.cities?[selectedPath.row]
            }
        }
    }
}
