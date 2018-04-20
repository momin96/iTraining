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
            print(data!)
            if data == nil {
                result = .Failure(error! as NSError)
            }
            else if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    result = self.resultFromData(date: data!)
                    print(result)
                }
                else {
                    let error = self.errorWithCode(code: response.statusCode, localizedDescription: "Bad Status code \(response.statusCode)")
                    result = .Failure(error)
                }
            }
            else {
                let error = self.errorWithCode(code: 1, localizedDescription: "Unexpected response")
                result = .Failure(error)
            }
        
            OperationQueue.main.addOperation({
                completionHandler(result)
            })
        }
        
        task.resume()
    }
    
    func courseFromDictionary(_ courseDict :NSDictionary) -> NSRCourse? {
        
        let title = courseDict["title"] as! String
        
        let urlString = courseDict["url"] as! String
        
        let upcomingArray = courseDict["upcoming"] as! [NSDictionary]
        
        let nextUpcomingDict = upcomingArray.first!
        
        let nextStartDateString = nextUpcomingDict["start_date"] as! String
        
        let url = NSURL(string: urlString)!
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let nextStartDate = dateFormatter.date(from: nextStartDateString)!
        
        return NSRCourse(title: title, url: url as URL, nextStartDate:
            nextStartDate)
    }
    
    func errorWithCode (code : Int, localizedDescription : String) -> NSError {
        return NSError(domain: "ScheduleFetcher", code: code, userInfo: [NSLocalizedDescriptionKey : localizedDescription])
    }
    
    
    func resultFromData(date : Data) -> FetchCourseResult {
        var error : NSError?
        let topLevelDict = try! JSONSerialization.jsonObject(with: date, options: JSONSerialization.ReadingOptions.mutableContainers)
        
        if let topLevelDict = topLevelDict as? NSDictionary {
            let courseDicts = topLevelDict["courses"] as? [NSDictionary]
            
            var courses : [NSRCourse] = []
            for courseDict in courseDicts! {
                if let course = courseFromDictionary(courseDict) {
                    courses.append(course)
                }
            }
            return .Success(courses)
        }
        else {
            return .Failure(error!)
        }
    }
    
}
