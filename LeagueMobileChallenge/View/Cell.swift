//
//  Cell.swift
//  LeagueMobileChallenge
//
//  Created by İsmail on 15.02.2022.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import UIKit

class Cell : UITableViewCell {
    
    // MARK: - Properties
    var postViewModel: PostViewModel? {
        didSet {
            configureData()
        }
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Test Test"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Test title title title"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "testestes test set set set set set sets ets etset set set set setsetsets etsetset setset setsetset set set"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "xxx")
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return imageView
    }()
    
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    
    // MARK: - Helpers
    
    private func configureCellUI() {
        let topStackView = UIStackView(arrangedSubviews: [avatarImage, nameLabel])
        topStackView.axis = .horizontal
        topStackView.distribution = .fillProportionally
        topStackView.alignment = .center
        topStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(topStackView)
        topStackView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 8, paddingRight: 8)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topStackView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 8)
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 8)
        

    }
    
    private func configureData() {
        nameLabel.text = postViewModel?.username
        titleLabel.text = postViewModel?.title
        descriptionLabel.text = postViewModel?.description
        avatarImage.image = postViewModel?.avatarImage
    }
    
}
