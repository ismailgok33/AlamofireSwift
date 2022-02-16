//
//  User.swift
//  LeagueMobileChallenge
//
//  Created by İsmail on 15.02.2022.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Foundation

struct User {
    let id: Int
    let avatar: Avatar
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
    
}

struct Avatar {
    let large: String
    let medium: String
    let thumbnail: String
}

struct Address {
    let street: String
    let suit: String
    let city: String
    let zipCode: String
    let geo: Geo
}

struct Geo {
    let lat: String
    let lng: String
}

struct Company {
    let name: String
    let catchPhrase: String
    let bs: String
}
