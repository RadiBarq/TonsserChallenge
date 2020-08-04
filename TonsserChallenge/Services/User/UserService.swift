//
//  UserService.swift
//  TonsserChallenge
//
//  Created by Harri on 8/3/20.
//  Copyright © 2020 Tonsser. All rights reserved.
//

import RxSwift
import Foundation
import RxCocoa

struct UserService: UserServiceType {
    
    // MARK: - Properties
    
    let baseURL = URL(string: "http://api.tonsser.com/58/users/peter-holm/followers")!
    
    // MARK: - Fetch
    
    func fetch(slug: String? = nil) -> Observable<[User]> {
        let response = Observable.from([slug])
            .flatMap { urlString -> Observable<URLRequest> in
                guard let urlString = urlString else {
                    return self.buildRequest(pathComponent: "", params: [])
                }
                return self.buildRequest(pathComponent: "", params: [("current_follow_slug", urlString)])
        }
        .flatMap { request -> Observable<Data> in
            let session = URLSession.shared
            return session.rx.response(request: request)
                .map { response, data in
                    switch response.statusCode {
                    case 200 ..< 300:
                        return data
                        
                    case 400 ..< 500:
                        throw UserServiceError.userNotFound
                        
                    default:
                        throw UserServiceError.serverError
                    }
            }
        }.share(replay: 1)
        
        return response
            .map { data in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(UserResponse.self, from: data).response
        }
    }
}
