//
//  UserViewModel.swift
//  LeagueMobileChallenge
//
//  Created by İsmail on 16.02.2022.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Foundation
import UIKit

//struct PostViewModel {
//    let avatarImage: String
//    let username: String
//    let title: String
//    let description: String
//
//    init(user: User, post: Post) {
//        avatarImage = user.avatar.thumbnail
//        username = user.username
//        title = post.title
//        description = post.body
//    }
//}

struct ShowPost {
    let avatarImage: String
    let username: String
    let title: String
    let description: String
    
    init(user: User, post: Post) {
        avatarImage = user.avatar.thumbnail
        username = user.username
        title = post.title
        description = post.body
    }
}

class PostViewModel : NSObject {
    
    private(set) var users: [User]?
    private(set) var posts: [Post]?
    private var showPosts: [ShowPost]?
    
    override init() {
        super.init()
//        fetchPostData()
    }
    
    // TODO: make completion (Result<> -> Void)
    func fetchPostData(completion: @escaping ([ShowPost]?) -> (Void)) {
        
        let group = DispatchGroup()
        
        APIController.shared.fetchUserToken { res, error in
            group.enter()
            
            // Get users
            APIController.shared.fetchUsers { data, error in
                defer {
                    group.leave()
                }
                
                guard let data = data, error == nil else { return }
                
                do {
                    self.users = try JSONDecoder().decode([User].self, from: data as! Data)
                }
                catch {
                    print(error.localizedDescription)
                }
            }
            
            group.enter()
            // Get posts
            APIController.shared.fetchPosts { posts, error in
                defer {
                    group.leave()
                }
                guard let posts = posts, error == nil else { return }
                
                do {
                    self.posts = try JSONDecoder().decode([Post].self, from: posts as! Data)
                }
                catch {
                    print(error.localizedDescription)
                }
            }
            
            group.notify(queue: .main) {
                
                print("DEBUG: girdiiiii")
                
                guard let posts = self.posts
                else {
                    print("DEBUG: cikti1")
                    completion(nil)
                    return
                    
                }
                guard let users = self.users
                else {
                    print("DEBUG: cikti2")
                    completion(nil)
                    return
                }
                            
                completion(self.mapPostswithUsers(posts: posts, users: users))
            }
        }
        
        
        
    }
    
    private func mapPostswithUsers(posts: [Post], users: [User]) -> [ShowPost] {
        let showPosts : [ShowPost] = posts.compactMap({ post in
            let userList = users.filter({
                $0.id == post.userId
            })
            guard userList.count > 0 else { return nil}
            return ShowPost(user: userList[0], post: post)
        })
        
        return showPosts
    }
    
}
