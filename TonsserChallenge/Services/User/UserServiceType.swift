//
//  UserService.swift
//  TonsserChallenge
//
//  Created by Harri on 8/3/20.
//  Copyright © 2020 Tonsser. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum UserServiceError: Error {

    case serverError
}

protocol UserServiceType: ServiceType {
   func fetch(slug: String?) -> Observable<[User]>
}

