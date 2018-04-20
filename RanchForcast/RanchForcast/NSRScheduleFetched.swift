//
//  NSRScheduleFetched.swift
//  RanchForcast
//
//  Created by Nasir Ahmed Momin on 20/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import Foundation

class NSRScheduleFetcher {
    
    enum FetchCourseResult {
        case Success([NSRCourse])
        case Failure(NSError)
    }
    
    
    let session : URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    
    func fetchCoursesUsingCompletionHandler(completionHandler : @escaping (FetchCourseResult) -> Void) {
        let url = URL(string: "http://bookapi.bignerdranch.com/courses.json")!
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            var result : FetchCourseResult
            print(data)
            if data == nil {
                result = .Failure(error! as NSError)
            }
            else {
                result = FetchCourseResult.Success([])
            }
            
            OperationQueue.main.addOperation({
                completionHandler(result)
            })
        }
        
        task.resume()
    }
    
}
