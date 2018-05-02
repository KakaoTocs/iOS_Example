//
//  ViewController.swift
//  AsyncExample
//
//  Created by DGSW_TEACHER on 2018. 5. 2..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func touchUpDownloadButton(_ sender: UIButton) {
        // https가 이닌 http이미지 다운시 info.plist 설정 필수
        
        let imageURL: URL = URL(string: "http://post.phinf.naver.net/20161004_125/1475545376913YRH3k_JPEG/%BC%F6%C1%A4%B5%CA_BGA-230_%C2%F8%BF%EB_%B4%DC%C3%BC_1.jpg")!
        let twiceURL: URL = URL(string: "https://pbs.twimg.com/media/CuskbBdUkAAruxk.jpg:orig")!
        
        OperationQueue().addOperation {
            let imageData: Data = try! Data.init(contentsOf: twiceURL)
            let image: UIImage = UIImage(data: imageData)!
            
            OperationQueue.main.addOperation {
                self.imageView.image = image
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

