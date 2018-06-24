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
//    var countries: [Country] = []
    
    // Test
    var Tcontries: [CountryJSON] = []
    var Tcity: [String : [CityJSON]] = [:]
    
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
        
        // JSON데이터 읽기
//        if let data = parseJSONData() {
//            self.countries = data
//        }
        parseJSONData()
        dump(Tcontries)
        dump(Tcity)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Tcontries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        let country: CountryJSON = self.Tcontries[indexPath.row]
        
        cell.textLabel?.text = country.koreanName
        cell.imageView?.image = UIImage(named: country.flagName!)
        cell.imageView?.contentMode = UIViewContentMode.scaleAspectFit
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
                cityViewController.cities  = self.Tcity[(self.Tcontries[selectedPath.row].koreanName)!]
                // 네비게이션바 제목 설정
                cityViewController.title = Tcontries[selectedPath.row].koreanName!
                // 네비게이션바 백버튼 색깔 설정
                cityViewController.navigationController?.navigationBar.tintColor = UIColor.white
            }
        }
    }
    
    // MARK: - Custon Method
    // JSON데이터 읽기
    func parseJSONData() {
        // 나라 정보 읽기
//        var tempCountiesData: [Country] = []
        let jsonDecoder: JSONDecoder = JSONDecoder()
        
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "countries") else {
            return
        }
        
        do {
            let countriesData: [CountryJSON] = try jsonDecoder.decode([CountryJSON].self, from: dataAsset.data)
            Tcontries = countriesData
            // 배열에 나라 추가
            dump(countriesData)
//            for countryData in countriesData {
//                tempCountiesData.append(Country(countryName: countryData.koreanName!, assetName: countryData.assetName!))
//            }
        } catch {
            print(error.localizedDescription)
        }
        
        // 각 나라에 도시 정보 추가
        for counter in 0..<Tcontries.count {
            guard let dataAsset: NSDataAsset = NSDataAsset(name: Tcontries[counter].assetName!) else {
                return
            }
            
            do {
                let citiesData: [CityJSON] = try jsonDecoder.decode([CityJSON].self, from: dataAsset.data)
                Tcity[Tcontries[counter].koreanName!] = citiesData
                // 도시 배열에 도시 추가
                dump(citiesData)
//                print(citiesData[0].fahrenheit)
//                print(citiesData[0].weatherIcon)
//                print(citiesData[0].weatherName)
//                print(citiesData[0].temperatureColor)
//                print(citiesData[0].rainFallColor)
//                for cityData in citiesData {
//                    tempCountiesData[counter].cities.append(City(name: cityData.cityName!, state: cityData.state!, rainfall: cityData.rainfallProbability!, celsius: cityData.celsius!))
//                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
//        return tempCountiesData
    }
}
