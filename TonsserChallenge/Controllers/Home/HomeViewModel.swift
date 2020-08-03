//
//  HomeViewModel.swift
//  TonsserChallenge
//
//  Created by Harri on 8/3/20.
//  Copyright © 2020 Tonsser. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct HomeViewModel {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    
    let sceneCoordinator: SceneCoordinatorType
    
    let userService: UserServiceType
    
    var users: BehaviorRelay<[User]>
    
    init(userService: UserServiceType, sceneCoordinator: SceneCoordinatorType) {
        self.userService = userService
        self.sceneCoordinator = sceneCoordinator
        self.users = BehaviorRelay<[User]>(value: [])
        fetchUsers(slug: nil)
    }
    
    func fetchUsers(slug: String?) {
        if let slug = slug {
            self.userService.fetch(slug: slug)
                .subscribe(
                    onNext:{ users in
                        let currentUsers = self.users.value
                        self.users.accept(currentUsers + users)
                })
                .disposed(by: disposeBag)
            
        } else {
            
            self.userService.fetch(slug: nil)
                .subscribe(
                    onNext:{ users in
                        let currentUsers = self.users.value
                        self.users.accept(currentUsers + users)
                })
                .disposed(by: disposeBag)
        }
    }
}
