//
//  CityTableCell.swift
//  Weather
//
//  Created by Kim on 2018. 6. 4..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit

class CityTableCell: UITableViewCell {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var rainFallLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
