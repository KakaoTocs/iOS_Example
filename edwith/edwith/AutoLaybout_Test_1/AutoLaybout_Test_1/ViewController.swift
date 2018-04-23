//
//  ViewController.swift
//  AutoLaybout_Test_1
//
//  Created by DGSW_TEACHER on 2018. 4. 2..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 서브뷰 생성
        let frame = CGRect(x: 60, y: 100, width: 240, height: 120)
        let subView = UIView(frame: frame)
        
        // 서브뷰 색상 설정
        subView.backgroundColor = UIColor.green
        
        // 서브부 추가
        view.addSubview(subView)
        print(view)
        dump(view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

