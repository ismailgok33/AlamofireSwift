//
//  UserViewModel.swift
//  LeagueMobileChallenge
//
//  Created by İsmail on 16.02.2022.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Foundation
import UIKit

struct PostViewModel {
    let avatarImage: UIImage
    let username: String
    let title: String
    let description: String
    
    init(user: User, post: Post) {
        avatarImage = UIImage(named: user.avatar.thumbnail) ?? UIImage()
        username = user.username
        title = post.title
        description = post.body
    }
}
