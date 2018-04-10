//
//  ViewController.swift
//  NSRAPIServices
//
//  Created by Nasir Ahmed Momin on 30/03/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, URLSessionDataDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let defaultSessionConfiguration = URLSessionConfiguration.default
        let ephemeralSessionConfiguration = URLSessionConfiguration.ephemeral
        let backgroundSessionConfiguration = URLSessionConfiguration.background(withIdentifier: "com.exilant.nasir")
        
        
        let url = URL(string: "www.google.com")!
        
        let cachePolicy = .returnCacheDataElseLoad as URLRequest.CachePolicy
        
        let urlRequest = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: 60)
        
        let session = URLSession(configuration: backgroundSessionConfiguration, delegate: self, delegateQueue: OperationQueue.main)
        
        session.dataTask(with: urlRequest).resume()
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            
        }
        
        
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didBecome streamTask: URLSessionStreamTask) {
        <#code#>
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

