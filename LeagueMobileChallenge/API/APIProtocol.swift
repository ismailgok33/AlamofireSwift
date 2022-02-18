//
//  APIProtocol.swift
//  LeagueMobileChallenge
//
//  Created by İsmail on 17.02.2022.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Foundation

protocol APIProtocol {
    
    func fetchUserToken(userName: String, password: String, completion: @escaping (String?, Error?) -> Void)
    func fetchPosts(completion: @escaping (Any?, Error?) -> Void)
    func fetchUsers(completion: @escaping (Any?, Error?) -> Void)
}
