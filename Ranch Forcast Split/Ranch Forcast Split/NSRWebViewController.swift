//
//  NSRWebViewController.swift
//  Ranch Forcast Split
//
//  Created by Nasir Ahmed Momin on 24/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Cocoa
import WebKit

class NSRWebViewController: NSViewController {

    var webView: WKWebView {
        return view as! WKWebView
    }
    
    
    override func loadView() {
        let webView = WKWebView()
        view = webView
    }
    
    
    func loadURL(_ url : URL) {
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10.0)
        webView.load(request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
