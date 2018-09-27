//
//  AddViewController.swift
//  ContrainerView
//
//  Created by Jinu Kim on 27/09/2018.
//  Copyright © 2018 Jinu Kim. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    deinit {
        print(#function)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    }
    
    // willMove -> 부모 화면에 새 화면이 보일때
    override func willMove(toParent parent: UIViewController?) {
        print(#function)
        if let `parent` = parent as UIViewController? {
            print(parent)
        }
    }
    
    // 화면에 보였을때 -> didMove
    override func didMove(toParent parent: UIViewController?) {
        print(#function)
        if let `parent` = parent as UIViewController? {
            print(parent)
        }
    }
    
    @IBAction func onRemoveChildViewController(_ sender: Any) {
        // willMove를 호출해 제거하는것을 알림
        self.willMove(toParent: nil)
        // 제약사항 제거
        self.view.removeFromSuperview()
        // 부모에 연결된 자식의 관계 제거
        self.removeFromParent()
    }

}
