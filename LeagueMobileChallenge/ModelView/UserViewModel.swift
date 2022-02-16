//
//  UserViewModel.swift
//  LeagueMobileChallenge
//
//  Created by İsmail on 16.02.2022.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Foundation

struct UserViewModel {
    let user: User?
    
    init(user: User) {
        self.user = user
    }
}
