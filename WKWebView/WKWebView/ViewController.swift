//
//  ViewController.swift
//  WKWebView
//
//  Created by Jinu Kim on 20/02/2019.
//  Copyright © 2019 com.kakaotocs. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

//    @IBOutlet weak var webView: WKWebView!
    var webView: WKWebView?
    let url = "http://192.168.21.9:8080"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentController = WKUserContentController()
        let config = WKWebViewConfiguration()
        contentController.add(self, name: "callbackHandler")
        config.userContentController = contentController
        
        self.webView = WKWebView(frame: self.view.frame, configuration: config)
        self.webView?.navigationDelegate = self
        self.webView?.uiDelegate = self
        self.view.addSubview(webView!)
//        self.webView.frame = self.view.frame
        self.webView?.load(URLRequest(url: URL(string: url)!))
    }

    @IBAction func nextButtonAction(_ sender: UIBarButtonItem) {
        let vc = DummyViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func refreshButtonAction(_ sender: UIBarButtonItem) {
        self.webView?.reload()
    }
    
    @IBAction func homeButtonAction(_ sender: UIBarButtonItem) {
        self.webView?.load(URLRequest(url: URL(string: url)!))
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Load Finishi!")
    }
}

extension ViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        print("Alert Handle")
    }
    
}

extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage)  {
        if message.name == "callbackHandler" {
            print(message.body)
            let label = UILabel(frame: CGRect(x: 50, y: 50, width: 200, height: 50))
            label.text = message.body as! String
            self.view.addSubview(label)
        }
    }
}
