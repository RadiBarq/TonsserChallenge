//
//  HomeView.swift
//  TonsserChallenge
//
//  Created by Kristiyan Dobrev on 03/07/2020.
//  Copyright © 2020 Tonsser. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class HomeView: ReusableUIView {
    
    // MARK: - Properties
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.getReueseIdentifier())
        return tableView
    }()
    
    private(set) var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.startAnimating()
        activityIndicator.color = .black
        activityIndicator.backgroundColor = .green
        activityIndicator.layer.masksToBounds = true
        activityIndicator.layer.cornerRadius = 5
        return activityIndicator
    }()
    
    // MARK: - Styling
    
    override func styleUI() {
        backgroundColor = .white
    }
    
    // MARK: - Constraints
    
    override func makeConstraints() {
        
        addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        self.addSubview(activityIndicator)
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.activityIndicator.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.activityIndicator.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
