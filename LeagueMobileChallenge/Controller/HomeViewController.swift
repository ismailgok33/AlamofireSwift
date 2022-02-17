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

    private var showPosts = [ShowPost]() {
        didSet {
            print("DEBUG: ShowPost is set: \(showPosts)")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private var postViewModel: PostViewModel!

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        getPostsFromVM()
        
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        self.title = "Posts"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(Cell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    private func getPostsFromVM() {
        postViewModel = PostViewModel()
        postViewModel.fetchPostData { showPosts in
            guard let posts = showPosts
            else {
                print("DEBUG: in VC - showPosts is empty")
                return
                
            }

            self.showPosts = posts
        }
    }

}


// MARK: - TableView Datasource
extension HomeViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showPosts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? Cell {
            cell.showPost = showPosts[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
}

// MARK: - TableView Delegate
extension HomeViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}
