//
//  MainTableViewController.swift
//  Weather
//
//  Created by DGSW_TEACHER on 2018. 4. 26..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit

class MainTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Property
    var countries: [Country] = []
    var cities: [String : [City]] = [:]
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // 네비게이션바 배경 색깔 설정
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.4196, green: 0.6196, blue: 1, alpha: 1)
        // 네비게이션바 타이틀 색깔 설정
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white] as [NSAttributedStringKey : Any]
        
        parseJSONData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        let country: Country = self.countries[indexPath.row]
        
        if let countryName = country.koreanName, let flagImageName = country.flagName {
            cell.textLabel?.text = countryName
            cell.imageView?.image = UIImage(named: flagImageName)
            cell.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        }
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "citySegue" {
            if let cityViewController = segue.destination as? CityTableViewController,
                let selectedPath = tableView.indexPathForSelectedRow {
                if let countryName = self.countries[selectedPath.row].koreanName {
                    // 선택된 국가의 도시 정보 전달
                    if let cities = self.cities[countryName] {
                        cityViewController.cities  = cities
                    }
                    // 네비게이션바 제목 설정
                    cityViewController.title = countryName
                }
                // 네비게이션바 백버튼 색깔 설정
                cityViewController.navigationController?.navigationBar.tintColor = UIColor.white
            }
        }
    }
    
    // MARK: - Custon Method
    // JSON데이터 읽기
    func parseJSONData() {
        // 나라 정보 읽기
        let jsonDecoder: JSONDecoder = JSONDecoder()
        
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "countries") else {
            return
        }
        
        do {
            let countriesData: [Country] = try jsonDecoder.decode([Country].self, from: dataAsset.data)
            countries = countriesData
        } catch {
            print(error.localizedDescription)
        }
        
        // 각 나라의 도시 정보 읽기
        for counter in 0..<countries.count {
            guard let countryAssetName = countries[counter].assetName else {
                continue
            }
            guard let dataAsset: NSDataAsset = NSDataAsset(name: countryAssetName) else {
                continue
            }
            
            do {
                let citiesData: [City] = try jsonDecoder.decode([City].self, from: dataAsset.data)
                if let countryName = countries[counter].koreanName {
                    // 도시 정보 추가
                    cities[countryName] = citiesData
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
