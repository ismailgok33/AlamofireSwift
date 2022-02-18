//
//  LeagueMobileChallengeTests.swift
//  LeagueMobileChallengeTests
//
//  Created by Kelvin Lau on 2019-01-09.
//  Copyright © 2019 Kelvin Lau. All rights reserved.
//

import XCTest
import Mocker
import Alamofire
@testable import LeagueMobileChallenge

class LeagueMobileChallengeTests: XCTestCase {

    func testGetUsersViaNetworkCall() {
        let expectation = self.expectation(description: "User response parse expectation")
        
        APIController.shared.fetchUserToken { res, err in
            
            APIController.shared.fetchUsers { data, error in

                XCTAssertNil(error)
                guard let data = data else {
                    XCTFail()
                    return
                }
                
                do {
                    
                    let users = try JSONDecoder().decode([User].self, from: data as! Data)
                    XCTAssertNotNil(users)
                    expectation.fulfill()
                }
                catch {
                    XCTFail(error.localizedDescription)
                }
                
            }
            
        }
        
        
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
//        wait(for: [expectation], timeout: 20)
    }
    
//    func testGetMockUsers() {
//        let mockAPIController = MockAPIController()
//
//        let expectation = self.expectation(description: "User response parse expectation")
//
//
//            mockAPIController.fetchUsers { data, error in
//
//                print("TESTDEBUG: user data is \(data)")
//
//                XCTAssertNil(error)
//                guard let data = data else {
//                    XCTFail()
//                    return
//                }
//
//                do {
//
//                    let users = try JSONDecoder().decode([User].self, from: data as! Data)
//                    XCTAssertNotNil(users)
//                    expectation.fulfill()
//                }
//                catch {
//                    XCTFail(error.localizedDescription)
//                }
//
//            }
//
//
//
//
//
//        self.waitForExpectations(timeout: 10.0, handler: nil)
//    }

}
