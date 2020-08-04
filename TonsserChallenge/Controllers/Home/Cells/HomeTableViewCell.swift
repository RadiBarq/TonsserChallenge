//
//  HomeTableViewCell.swift
//  TonsserChallenge
//
//  Created by Harri on 8/3/20.
//  Copyright © 2020 Tonsser. All rights reserved.
//

import UIKit
import SDWebImage

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private lazy var name: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        return label
    }()
    
    private lazy var profileImageView: UIImageView = {
        var image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 15
        return image
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style
            , reuseIdentifier: reuseIdentifier)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.imageView?.image = nil
    }

    // MARK: - Configure
    
    func configure(with user: User) {
        self.name.text = user.name
        
        if let profilePicture = user.profilePicture {
            self.profileImageView.sd_setImage(with: URL(string: profilePicture)!)
        } else {
            self.profileImageView.image = UIImage(systemName: "person.fill")
            self.profileImageView.tintColor = .green
        }
    }
      
    // MARK: - Constraints
    
    private func makeConstraints() {
        
        self.addSubview(name)
        self.addSubview(profileImageView)
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leftAnchor.constraint(equalTo: self.profileImageView.rightAnchor, constant: 15).isActive = true
        name.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        name.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        name.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        name.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
       
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        profileImageView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 15).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -15).isActive = true
    }
    
    // MARK: - Type Functions
    
    static func getReueseIdentifier() -> String {
        return "HomeTableViewCell"
    }
}
