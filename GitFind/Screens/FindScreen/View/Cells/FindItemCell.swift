//
//  FindItemCell.swift
//  GitFind
//
//  Created by Misha Fedorov on 07.03.2022.
//

import UIKit
import Kingfisher

class FindItemCell: UITableViewCell {
    
    private let nameLabel = UILabel()
    private let fullNameLabel = UILabel()
    private let urlLabel = UILabel()
    private let avatarImageView = UIImageView()
    private let authorNameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
    }

    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(nameLabel)
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(authorNameLabel)
        // Name label
        nameLabel.textColor = .systemPink
        nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        nameLabel.numberOfLines = 1
        
        fullNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        fullNameLabel.textColor = .lightGray
        
        avatarImageView.layer.masksToBounds = true
        authorNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
    }

    func configure(_ model: RepositoryItemModel) {
        nameLabel.text = model.name
        fullNameLabel.text = model.fullName
        avatarImageView.kf.setImage(with: model.ownerModel.avatarUrl)
        authorNameLabel.text = model.ownerModel.login
    }

    private func setupLayout() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        urlLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fullNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            fullNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            fullNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: fullNameLabel.leftAnchor),
            nameLabel.leftAnchor.constraint(equalTo: fullNameLabel.rightAnchor),
            nameLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 10),
            nameLabel.heightAnchor.constraint(equalToConstant: 18)
        ])

        NSLayoutConstraint.activate([
            avatarImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            avatarImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            avatarImageView.heightAnchor.constraint(equalToConstant: 32),
            avatarImageView.widthAnchor.constraint(equalToConstant: 32),
            avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            authorNameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 10),
            authorNameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            authorNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            authorNameLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
