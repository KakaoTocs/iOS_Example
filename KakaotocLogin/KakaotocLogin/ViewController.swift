//
//  ViewController.swift
//  KakaotocLogin
//
//  Created by Jinu Kim on 22/11/2018.
//  Copyright © 2018 Jinu Kim. All rights reserved.
//

// http://faith-developer.tistory.com/44
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var kakaoLoginButton: UIButton!
    @IBOutlet weak var textView: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginAction(_ sender: UIButton) {
        let session: KOSession = KOSession.shared()
        
        if session.isOpen() {
            session.close()
        }
        
        session.presentingViewController = self
        session.open(completionHandler: { (error) -> Void in
            if error != nil{
                print(error?.localizedDescription)
            }else if session.isOpen() == true{
                KOSessionTask.meTask(completionHandler: { (profile , error) -> Void in
                    if profile != nil{
                        DispatchQueue.global(qos: .userInteractive).async(execute: { () -> Void in
                            let kakao : KOUser = profile as! KOUser
                            //String(kakao.ID)
                            if let value = kakao.properties!["nickname"] as? String{
                                DispatchQueue.main.async {
                                    self.textView.text = "nickname : \(value)\r\n"
                                }
                            }
                            if let value = kakao.properties!["profile_image"] as? String{
                                DispatchQueue.main.async {
                                    self.imageView.image = UIImage(data: NSData(contentsOf: NSURL(string: value)! as URL)! as Data)
                                }
                            }
                            if let value = kakao.properties!["thumbnail_image"] as? String{
                                DispatchQueue.main.async {
                                    self.imageView2.image = UIImage(data: NSData(contentsOf: NSURL(string: value)! as URL)! as Data)
                                }
                            }
                        })
                    }
                })
            }else{
                print("isNotOpen")
            }
        })
    }
    
}

