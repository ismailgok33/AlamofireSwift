//
//  Post.swift
//  LeagueMobileChallenge
//
//  Created by İsmail on 16.02.2022.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Foundation

struct Post : Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
