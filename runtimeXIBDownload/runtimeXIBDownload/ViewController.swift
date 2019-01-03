//
//  ViewController.swift
//  runtimeXIBDownload
//
//  Created by Jinu Kim on 28/12/2018.
//  Copyright © 2018 com.kakaotocs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // 터미널에서 "ibtool --compile TestXIB.nib TestXIB.xib" 입력하면 XIB가 NIB로 컴파일됨
    // Server에 XIB를 컴파일해 얻은 NIB파일을 저장 -> App에서 Server통해 받은 NIB파일 저장 -> 앱에서 읽어서 사용
    // 서버에서 받은 NIB파일은 Debug모드에서 시뮬레이터 -> Document 경로에 저장됨 !!!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let testXIB = TestXIB(frame: UIScreen.main.bounds)
        self.view.addSubview(testXIB)
    }
}

