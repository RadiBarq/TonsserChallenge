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
    
    private var users: BehaviorRelay<[User]>
    
    private var usersCount: Int {
        return self.users.value.count
    }
    
    private var loading: PublishSubject<Bool>
    
    private var errorMessage: PublishSubject<String>

    private var disposeBag = DisposeBag()
    
    private var sceneCoordinator: SceneCoordinatorType
    
    private var userService: UserServiceType
    
    var usersObservable: Driver<[User]> {
        self.users.asDriver()
    }
    
    var loadingObservable: Driver<Bool> {
        self.loading.asDriver(onErrorJustReturn: false)
    }
    
    var errorMessageObservable: Driver<String> {
        self.errorMessage.asDriver(onErrorJustReturn: "Something Went Wrong")
    }
    
    init(userService: UserServiceType, sceneCoordinator: SceneCoordinatorType) {
        self.userService = userService
        self.sceneCoordinator = sceneCoordinator
        self.users = BehaviorRelay<[User]>(value: [])
        self.loading = PublishSubject<Bool>()
        self.errorMessage = PublishSubject<String>()
        fetchUsers(slug: nil)
    }
    
    // MARK: - Fetch Functions
    
    func fetchNextPage() {
        if usersCount > 0 {
            let lastSlug = self.users.value[usersCount - 1].slug
            fetchUsers(slug: lastSlug)
        }
    }
    
    func fetchUsers(slug: String?) {
        loading.onNext(true)
        self.userService.fetch(slug: slug)
            .subscribe(
                onNext:{ users in
                    let currentUsers = self.users.value
                    self.users.accept(currentUsers + users)
            }, onError: { error in
                self.loading.onNext(false)
                
                guard let error = error as? UserServiceError else {
                    self.errorMessage.onNext("Something Went Wrong")
                    return
                }
                
                switch error {
                case .serverError:
                    self.errorMessage.onNext("Network Error")
                case .userNotFound:
                    self.errorMessage.onNext("User Not Found")
                }
                
            },  onCompleted: {
                self.loading.onNext(false)
            })
            .disposed(by: disposeBag)
    }
}
