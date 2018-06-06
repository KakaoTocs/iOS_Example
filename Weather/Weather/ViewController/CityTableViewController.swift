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
    var country: Country?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        // 네비게이션바 제목 설정
        self.title = country?.name
        // 네비게이션바 백버튼 색깔 설정
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = country?.cities.count {
            return count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as? CityTableCell else{
            return UITableViewCell()
        }

        if let city = country?.cities[indexPath.row] {
            // 도시 이름
            cell.cityNameLabel.text = city.name
            // 온도
            cell.temperatureLabel.text = "섭씨 \(city.celsius)도 / 화씨 \(city.fahrenheit)도"
            cell.temperatureLabel.textColor = city.temperatureColor
            // 강수확률
            cell.rainFallLabel.text = "강수확률 \(city.rainfall)%"
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
                detailViewController.city = self.country?.cities[selectedPath.row]
            }
        }
    }
}
