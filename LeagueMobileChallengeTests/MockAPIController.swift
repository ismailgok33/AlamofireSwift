//
//  MockAPIController.swift
//  LeagueMobileChallengeTests
//
//  Created by İsmail on 17.02.2022.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Foundation
@testable import LeagueMobileChallenge

class MockAPIController {
    var shouldFetchTokenReturnsTrue = true
    
    init(_ shouldFetchTokenReturnsTrue: Bool) {
        self.shouldFetchTokenReturnsTrue = shouldFetchTokenReturnsTrue
    }
    
    convenience init() {
        self.init(true)
    }
    
    enum MockAPIErrors : Error {
        case tokenError
        case postError
        case userError
    }
    
    func reset() {
        shouldFetchTokenReturnsTrue = true
    }
    
    let mockUserJson: Data = Data(
        "{\"id\": 1,\"avatar\": {\"large\": \".../women/71.jpg\",\"medium\": \".../med/women/71.jpg\",\"thumbnail\": \".../thumb/women/71.jpg\" },\"name\": \"Leanne Graham\",\"username\": \"Bret\",\"email\": \"Sincere@april.biz\",\"address\": {\"street\": \"Kulas Light\",\"suite\": \"Apt. 556\",\"city\": \"Gwenborough\",\"zipcode\": \"92998-3874\",\"geo\": {\"lat\": \"-37.3159\",\"lng\": \"81.1496\"}},\"phone\": \"1-770-736-8031 x56442\",\"website\": \"hildegard.org\",\"company\": {\"name\": \"Romaguera-Crona\",\"catchPhrase\": \"Multi-layered...\",\"bs\": \"harness real-time e-markets\"}}".utf8)
    
    
    let mockPostJson: Data =
        Data("{\"userId\": 1,\"id\": 26,\"title\": \"est et quae odit qui non\",\"body\": \"similique esse doloribus nihil ...\"}".utf8)
    
}

extension MockAPIController : APIProtocol {
    func fetchUserToken(userName: String = "", password: String = "", completion: @escaping (String?, Error?) -> Void) {
       // Since the token needs to be generated from the server in order to be validated
        // It will always return true here...
        
        if(shouldFetchTokenReturnsTrue) {
            completion("mock token", nil)
        }
        else {
            completion(nil, MockAPIErrors.tokenError)
        }
    }

    func fetchPosts(completion: @escaping (Any?, Error?) -> Void) {
        do {
//            let posts = try JSONDecoder().decode([Post].self, from: mockPostJson as! Data)
            completion(mockPostJson, nil)
        }
        catch {
            print(error.localizedDescription)
            completion(nil, MockAPIErrors.postError)
        }
    }

    func fetchUsers(completion: @escaping (Any?, Error?) -> Void) {
        do {
//            let users = try JSONDecoder().decode([User].self, from: mockUserJson as! Data)
            completion(mockUserJson, nil)
        }
        catch {
            print(error.localizedDescription)
            completion(nil, MockAPIErrors.userError)
        }
    }
}
