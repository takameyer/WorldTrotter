//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Andrew Meyer on 17.01.18.
//  Copyright © 2018 Designation Inc. All rights reserved.
//

import Foundation
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let targetUrl = URL(string: "https://www.leo.org")
        let request = URLRequest(url: targetUrl! )
        webView.load(request)
    }
}
