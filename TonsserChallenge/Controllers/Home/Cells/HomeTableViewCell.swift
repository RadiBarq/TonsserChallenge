//
//  HomeTableViewCell.swift
//  TonsserChallenge
//
//  Created by Harri on 8/3/20.
//  Copyright © 2020 Tonsser. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private lazy var name: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        return label
    }()
    
    private lazy var profilePicture: UIImageView = {
        var image = UIImageView()
        image.layer.masksToBounds = true
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
    
    
    // MARK: - Configure
    
    func configure(with user: User) {
        name.text = user.name
        profilePicture.backgroundColor = .red
    }
      
    // MARK: - Constraints
    
    private func makeConstraints() {
        
        self.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leftAnchor.constraint(equalTo: self.profilePicture.rightAnchor, constant: 15).isActive = true
        name.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        name.centerYAnchor.constraint(equalTo: profilePicture.centerYAnchor).isActive = true
        
        self.addSubview(profilePicture)
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        profilePicture.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        profilePicture.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profilePicture.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
