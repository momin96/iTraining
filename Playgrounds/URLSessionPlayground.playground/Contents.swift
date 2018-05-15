//: Playground - noun: a place where people can play

import Foundation


// Initilize cache for a image
let size = 1 * 1000 * 1000//
let imageCache = URLCache.init(memoryCapacity: size, diskCapacity: size, diskPath: nil)

// Specified URL
let url = URL.init(string: "http://google.com");
var urlRequest = URLRequest(url: url!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 25)



// Setting received Response data
let urlResponse = URLResponse();
let cachedResponse = CachedURLResponse.init(response: urlResponse, data: Data.init(), userInfo: [:], storagePolicy: .allowedInMemoryOnly)
imageCache.storeCachedResponse(cachedResponse, for: urlRequest)

// Retriving saved response
imageCache.cachedResponse(for: urlRequest)

///-------------------------------------------

// Caching mechanisam using NSURLSessionDataTask
let session = URLSession(configuration: .ephemeral);
var dataTask : URLSessionDataTask?
dataTask = session.dataTask(with: urlRequest) { (data, urlResponse, error) in
    print("urlResponse \(String(describing: urlResponse))")
    let dataTaskCached = CachedURLResponse(response: urlResponse!, data: data!, userInfo: [:], storagePolicy: .allowed)
    
    imageCache.storeCachedResponse(dataTaskCached, for: dataTask!);
}

dataTask?.resume()
