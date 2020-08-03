//
//  HomeView.swift
//  TonsserChallenge
//
//  Created by Kristiyan Dobrev on 03/07/2020.
//  Copyright © 2020 Tonsser. All rights reserved.
//

import UIKit

class HomeView: ReusableUIView {
    
    // MARK: - Properties
    
    private let padding: CGFloat = 16
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello World !"
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Styling
    
    override func styleUI() {
        backgroundColor = .white
    }
    
    // MARK: - Constraints
    
    override func makeConstraints() {
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
    }
}
