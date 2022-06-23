//
//  AuthViewModelTests.swift
//  happy-trackerTests
//
//  Created by Mirna Helmy on 4/5/22.
//

import XCTest
@testable import EHC

class AuthViewModelTests: XCTestCase {
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_AuthViewModel_isError_shouldBeFalse() {
        
        let vm = AuthViewModel()
        
        XCTAssertFalse(vm.isError)
        XCTAssertNil(vm.authError)
    }
    
    func test_AuthViewModel_setError_isErrorShouldBeTrue() {
        
        // Given
        let vm = AuthViewModel()
        
        // When
        vm.setError(AuthError.emptyName)
        
        // Then
        XCTAssertNotNil(vm.authError)
        XCTAssertTrue(vm.isError)
    }
}
