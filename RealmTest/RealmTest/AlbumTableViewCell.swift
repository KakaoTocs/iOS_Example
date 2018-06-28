//
//  AlbumTableViewCell.swift
//  RealmTest
//
//  Created by Kim on 2018. 6. 25..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumnailView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        thumnailView.layer.cornerRadius = 5.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        thumnailView.image = UIImage(named: "placeholder")
    }

}
