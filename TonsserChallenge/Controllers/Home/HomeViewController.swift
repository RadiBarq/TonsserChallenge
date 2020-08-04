//
//  HomeViewController.swift
//  TonsserChallenge
//
//  Created by Kristiyan Dobrev on 03/07/2020.
//  Copyright © 2020 Tonsser. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class HomeViewController: BindableViewController<HomeView, HomeViewModel> {

    override func viewDidLoad() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Home"
    }
    
    // MARK: - Bind View Model
    
    func bindViewModel() {
        
        self.viewModel.usersObservable.drive(layout.tableView.rx.items(cellIdentifier: HomeTableViewCell.getReueseIdentifier(), cellType: HomeTableViewCell.self)) {
            (row, model, cell) in
            cell.configure(with: model)
        }.disposed(by: disposeBag)
        
        self.viewModel.loadingObservable.drive( self.layout.activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        self.viewModel.errorMessageObservable
            .drive(onNext: { errorMessage in
            
            self.showErrorMessage(errorMessage: errorMessage)
        })
        .disposed(by: disposeBag)
        
        self.layout.tableView.rx.contentOffset
            .flatMap { [unowned self] offset in
                offset.y + self.layout.tableView.frame.size.height > self.layout.tableView.contentSize.height
                    ? Observable.just(()) : Observable.empty()
        }
        .throttle(.seconds(3), scheduler: MainScheduler.instance)
        .subscribe(onNext: {
            self.viewModel.fetchNextPage()
        })
        .disposed(by: disposeBag)
    }
    
    func showErrorMessage(errorMessage: String) {
        
        let alertController = UIAlertController(title: "Error: ", message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default))
        
        self.present(alertController, animated: true)
    }
}
