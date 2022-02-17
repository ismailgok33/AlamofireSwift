//
//  HomeViewController.swift
//  LeagueMobileChallenge
//
//  Created by İsmail on 15.02.2022.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class HomeViewController: UITableViewController {
    
    // MARK: - Properties

    private var postViewModels = [PostViewModel]() {
        didSet {
            print("DEBUG: postViewModels is set: \(postViewModels)")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private var users: [User]? {
        didSet {
            self.initViewModels(users: users ?? [], posts: posts ?? [])
        }
    }
    private var posts: [Post]? {
        didSet {
            self.initViewModels(users: users ?? [], posts: posts ?? [])
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        
        // TODO: Try to call these api calls more elegant way
        
        let group = DispatchGroup()
        group.enter()
        
        APIController.shared.fetchUserToken { res, error in
            
            defer {
                group.leave()
            }
            
            // Get users
            APIController.shared.fetchUsers { data, error in
                guard let data = data, error == nil else { return }
                
                do {
                    self.users = try JSONDecoder().decode([User].self, from: data as! Data)
//                    print("DEBUG: users are \(self.users)")
                }
                catch {
                    print(error.localizedDescription)
                }
            }
            
            // Get posts
            APIController.shared.fetchPosts { posts, error in
                guard let posts = posts, error == nil else { return }
                
                do {
                    self.posts = try JSONDecoder().decode([Post].self, from: posts as! Data)
//                    print("DEBUG: posts are \(self.posts)")
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        group.notify(queue: .main) {
            
            print("DEBUG: girdiiiii")
            
            guard let posts = self.posts else {print("DEBUG: cikti1")
                return }
            guard let users = self.users else {print("DEBUG: cikti2")
                return }
            
//            self.postViewModels = posts.compactMap({ post in
//                var user = users.filter({
//                    $0.id == post.userId
//                })
//                var postVm: PostViewModel = PostViewModel(user: user[0], post: post)
//                return postVm
//            })
            self.initViewModels(users: users, posts: posts)
        }
        
        
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(Cell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    private func initViewModels(users: [User], posts: [Post]) {
        self.postViewModels = posts.compactMap({ post in
            let userList = users.filter({
                $0.id == post.userId
            })
            guard userList.count > 0 else { return nil}
            print("DEBUG: avatar image url string is \(userList[0].avatar.thumbnail)")
            return PostViewModel(user: userList[0], post: post)
        })
    }

}


// MARK: - TableView Datasource
extension HomeViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? Cell {
            
            cell.postViewModel = postViewModels[indexPath.row]
            print("DEBUG: avatar image is \(cell.postViewModel?.avatarImage)")
            
            return cell
        }
        
        return UITableViewCell()
    }
    
}

// MARK: - TableView Delegate
extension HomeViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
