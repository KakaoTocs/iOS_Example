//
//  ViewController.swift
//  ContrainerView
//
//  Created by Jinu Kim on 27/09/2018.
//  Copyright © 2018 Jinu Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollViewContainerViewWidth: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollViewContainerViewWidth.constant = UIScreen.main.bounds.size.width * 2
    }
    
    @IBAction func onAddChildController(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Other", bundle: nil)
        let addViewController = storyboard.instantiateViewController(withIdentifier: "AddViewController")
        
        self.addChild(addViewController)
        self.view.addSubview(addViewController.view)
        
        addViewController.didMove(toParent: self)
    }


}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("Current X, Y are X: \(scrollView.contentOffset.x), Y: \(scrollView.contentOffset.y)")
        let currentPage = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        print("Current page: \(currentPage)")
    }
}
