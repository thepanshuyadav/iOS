//
//  ViewController.swift
//  Browser
//
//  Created by Deepanshu Yadav on 06/01/20.
//  Copyright © 2020 Deepanshu Yadav. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView : WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://codelabs.developers.google.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        title = "Google CodeLabs"
        navigationController?.navigationBar.prefersLargeTitles = true
    }


}

