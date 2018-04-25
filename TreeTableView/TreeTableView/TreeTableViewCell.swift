//
//  TreeTableViewCell.swift
//  TreeTableView
//
//  Created by DGSW_TEACHER on 2018. 4. 25..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit

class TreeTableViewCell: UITableViewCell {

    @IBOutlet weak var treeButton: UIButton!
    @IBOutlet weak var treeLabel: UILabel!
    var treeNode: TreeViewNode!
    
    override func draw(_ rect: CGRect) {
        var cellFrame: CGRect = self.treeLabel.frame
        var buttonFrame: CGRect = self.treeButton.frame
        let indentation: Int = self.treeNode.nodeLevel! * 25
        cellFrame.origin.x = buttonFrame.size.width + CGFloat(indentation) + 5
        buttonFrame.origin.x = 2 + CGFloat(indentation)
        self.treeLabel.frame = cellFrame
        self.treeButton.frame = buttonFrame
    }
    
    func setButtonBackgroundImage(backgroundImage: UIImage) {
        self.treeButton.setBackgroundImage(backgroundImage, for: .normal)
    }
    
    @IBAction func expand(sender: AnyObject) {
        if self.treeNode != nil {
            if self.treeNode.nodeChildren != nil {
                if self.treeNode.isExpanded == GlobalVariables.TRUE {
                    self.treeNode.isExpanded = GlobalVariables.FALSE
                } else {
                    self.treeNode.isExpanded = GlobalVariables.TRUE
                }
            } else {
                self.treeNode.isExpanded = GlobalVariables.FALSE
            }
            self.isSelected = false
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TreeNodeButtonClicked"), object: self)
        }
    }
}
