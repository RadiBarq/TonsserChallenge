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
    
    let baseURL = URL(string: "http://api.tonsser.com/58/users/followers")!
    
    func fetch(slug: String? = nil) -> Observable<[User]> {
        let response = Observable.from([slug])
            .map { urlString -> Observable<URLRequest> in
                guard let urlString = urlString else {
                    return self.buildRequest(pathComponent: "", params: [])
                }
                return self.buildRequest(pathComponent: "", params: [("current_follow_slug", urlString)])
        }
        .flatMap { request -> Observable<Data> in
            let session = URLSession.shared
            return request.flatMap { request in
                return session.rx.response(request: request)
                    .filter { response, _ in
                        return 400 ..< 500 ~= response.statusCode
                    }
                    .map() { response, data in
                    switch response.statusCode {
                    case 200 ..< 300:
                        return data
                        
                    default:
                        throw UserServiceError.serverError
                    }
                }
            }
        }

        return response
            .map { data in
                let decoder = JSONDecoder()
                return try decoder.decode([User].self, from: data)
        }
    }
}
