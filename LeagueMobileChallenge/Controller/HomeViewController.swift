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

    let users: [UserViewModel] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(Cell.self, forCellReuseIdentifier: reuseIdentifier)
    }

}


// MARK: - TableView Datasource
extension HomeViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? Cell {
            
            
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