//
//  RecordSessionViewModel.swift
//  happy-trackerTests
//
//  Created by Mirna Helmy on 4/5/22.
//

import XCTest
@testable import EHC

class RecordSessionViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func test_RecordSessionViewModel_init_status_should_equal_notStarted() {
        
        // Given
        let vm = RecordSessionViewModel()
        
        // Then
        XCTAssertEqual(vm.status, RecordSessionViewModel.Status.notStarted)
    }
    
    func test_RecordSessionViewModel_status_should_equal_isRecording() {
        
        // Given
        let vm = RecordSessionViewModel()
        
        vm.startSession()
        
        // Then
        XCTAssertEqual(vm.status, RecordSessionViewModel.Status.isRecording)
    }
    
    
    func test_RecordSessionViewModel_submitSession_statusShoulEqualToDone() {
        //Given
        let vm = RecordSessionViewModel()
        
        //When
        vm.startSession()
        vm.submitSession(comment: "")
        
        //Then
        XCTAssertTrue(vm.self.status == .done)
    }
    
    
    func test_RecordSessionViewModel_status_shouldBeReset_notStarted() {
        //Given
        let vm = RecordSessionViewModel()
        
        //When
        vm.startSession()
        vm.resetSession()
        
        //Then
        XCTAssertTrue(vm.self.status  == .notStarted)
        
    }
    
}
