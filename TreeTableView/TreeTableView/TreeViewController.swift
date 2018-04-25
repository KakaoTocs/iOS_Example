//
//  TreeViewController.swift
//  TreeTableView
//
//  Created by DGSW_TEACHER on 2018. 4. 25..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit

class TreeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var displayArray = [TreeViewNode]()
    var indentation: Int = 0
    var nodes: [TreeViewNode] = []
    var data: [TreeViewData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(TreeViewController.ExpandCollapseNode(notification:)), name: NSNotification.Name(rawValue: "TreeNodeButtonClicked"), object: nil)
        
        data = TreeViewList.LoadInitialData()
        print(data)
        
        nodes = TreeViewList.LoadInitialNodes(dataList: data)
        print(nodes)
        
        self.LoadDisplayArray()
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func ExpandCollapseNode(notification: NSNotification) {
        self.LoadDisplayArray()
        self.tableView.reloadData()
    }
    
    func LoadDisplayArray() {
        self.displayArray = [TreeViewNode]()
        for node: TreeViewNode in nodes {
            self.displayArray.append(node)
            if node.isExpanded == GlobalVariables.TRUE {
                self.AddChildrenArray(childrenArray: node.nodeChildren as! [TreeViewNode])
            }
        }
    }
    
    func AddChildrenArray(childrenArray: [TreeViewNode]) {
        for node: TreeViewNode in childrenArray {
            self.displayArray.append(node)
            if node.isExpanded == GlobalVariables.TRUE {
                if node.nodeChildren != nil {
                    self.AddChildrenArray(childrenArray: node.nodeChildren as! [TreeViewNode])
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let node: TreeViewNode = self.displayArray[indexPath.row]
        
        let cell = (self.tableView.dequeueReusableCell(withIdentifier: "cell") as! TreeTableViewCell)
        
        cell.treeNode = node
        cell.treeLabel.text = node.nodeObject as! String?
        
        if node.isExpanded == GlobalVariables.TRUE {
            cell.setButtonBackgroundImage(backgroundImage: UIImage(named: "whiteOpen")!)
        } else {
            cell.setButtonBackgroundImage(backgroundImage: UIImage(named: "whiteClose")!)
        }
        
        cell.setNeedsDisplay()
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
