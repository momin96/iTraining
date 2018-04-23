//
//  ScheduleFetcherTests.swift
//  RanchForcastTests
//
//  Created by Nasir Ahmed Momin on 23/04/18.
//  Copyright © 2018 Nasir Ahmed Momin. All rights reserved.
//

import XCTest

class ScheduleFetcherTests: XCTestCase {

    var fetcher : NSRScheduleFetcher!
    
    override func setUp() {
        super.setUp()

        fetcher = NSRScheduleFetcher()
    }
    
    override func tearDown() {
        
        fetcher = nil
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
