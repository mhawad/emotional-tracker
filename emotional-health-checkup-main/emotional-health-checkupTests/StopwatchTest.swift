//
//  StopwatchTest.swift
//  happy-trackerTests
//
//  Created by Patrick Fuller on 4/7/22.
//

import XCTest
@testable import EHC

class StopwatchTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_Stopwatch_starts_at_0() {
        // Given
        let stopwatch = Stopwatch()
        
        // Then
        XCTAssertEqual(stopwatch.time, 0)
    }
    
    // Not getting currently testing asynchronous timer properly
    //    func test_Stopwatch_start_stop_at_various_time() {
    //        // Given
    //        let stopwatch = Stopwatch()
    //        let waitTime = 1
    //
    //        // When
    //        DispatchQueue.main.async {
    //            stopwatch.startStop()
    //
    //            DispatchQueue(label: "test").sync {}
    //
    //            Thread.sleep(forTimeInterval: 3)
    //            stopwatch.startStop()
    //        }
    //        Thread.sleep(forTimeInterval: 10)
    //        // Then
    //        XCTAssertEqual(stopwatch.time, waitTime)
    //        XCTAssertEqual(stopwatch.time, -1)
    //    }
    //
    //    func test_Stopwatch_restartsFrom0() {
    //        // Given
    //        let stopwatch = Stopwatch()
    //        
    //        // When
    //        stopwatch.startStop()
    //        sleep(3)
    //        stopwatch.startStop()
    //        stopwatch.startStop()
    //
    //        // Then
    //        XCTAssertEqual(stopwatch.time, 0)
    //    }
}
