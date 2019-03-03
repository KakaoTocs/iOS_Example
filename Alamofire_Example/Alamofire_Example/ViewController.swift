//
//  ViewController.swift
//  Alamofire_Example
//
//  Created by Jinu Kim on 15/02/2019.
//  Copyright © 2019 com.kakaotocs. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func testGET() {
        request("https://www.httpbin.org/get").responseJSON { response in
            if let JSONData = response.result.value {
                var jsonObject = JSONData as! [String: AnyObject]
                let origin = jsonObject["origin"] as! String
                let url = jsonObject["url"] as! String
                print("JSON: \(jsonObject)")
                print("\nIP Address Origin: \(origin)")
                print("\nURL of Request: \(url)")
                print("Hello, this is message 1!")
            }
        }
    }
    
    func GETWithCodable() {
        struct Country: Decodable {
            let name: String
            let capital: String
        }
        
        var countries = [Country]()
          
        let url = URL(string: "https://restcountries.eu/rest/v2/all")!
        
        request(url).responseJSON { response in
            guard let result = response.data else {
                return
            }
            countries = try! JSONDecoder().decode([Country].self, from: result)
            
            for country in countries {
                print("\(country.name): \(country.capital)")
            }
        }
    }
    
    func a() {
        let URL = "https://api.github.com/users"
//        let
        request(URL, method: .get, parameters: [:], encoding: URLEncoding.default, headers:  ["Content-Type":"application/json", "Accept":"application/json"])
        .validate(statusCode: 200..<300)
            .responseJSON { response in
                if let JSON = response.result.value {
                    print(JSON)
                }
        }
        
    }

    @IBAction func testGETButtonAction(_ sender: UIButton) {
        testGET()
    }
    
    @IBAction func testGETWithCodable(_ sender: UIButton) {
        GETWithCodable()
    }
    
    @IBAction func testHeaderButtonAction(_ sender: UIButton) {
        a()
    }
}

