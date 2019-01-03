//
//  TestXIB.swift
//  runtimeXIBDownload
//
//  Created by Jinu Kim on 28/12/2018.
//  Copyright © 2018 com.kakaotocs. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {
    @IBInspectable var isCenter: Bool = true {
        willSet(newValue) {
            if newValue {
                self.backgroundColor = UIColor.red
            }
        }
    }
}

class TestXIB: UIView {
    
    @IBOutlet weak var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        // 프로젝트내에 XIB파일이 포함되어 있지만 "TestXIB"를 읽어오는 bundle 생성 경로를 NIB가 있는 폴더로 잡혀있어 NIB를 사용한다(=XIB X)!!
        let rootDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        if let bundle = Bundle(url: rootDirectory) {
            print(bundle)
            let nib = bundle.loadNibNamed("TestXIB", owner: self, options: nil)?.first as! UIView
            
            nib.frame = self.bounds
            nib.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            self.backgroundColor = UIColor.red
            self.addSubview(nib)
        } else {
            print("Fail")
        }
        
        self.label.text = "Test Success"
    }
}
