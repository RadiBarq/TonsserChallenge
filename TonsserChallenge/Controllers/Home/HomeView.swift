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
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
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
    }
}
