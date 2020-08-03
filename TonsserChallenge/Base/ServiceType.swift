//
//  ServiceType.swift
//  TonsserChallenge
//
//  Created by Harri on 8/3/20.
//  Copyright © 2020 Tonsser. All rights reserved.
//

import Foundation
import RxSwift

protocol ServiceType {
    
    var baseURL: URL { get }
    
    func buildRequest(method: String, pathComponent: String, params: [(String, String)]) -> Observable<URLRequest>
}

extension ServiceType {
    func buildRequest(method: String = "GET", pathComponent: String, params: [(String, String)]) -> Observable<URLRequest> {
        
        let request: Observable<URLRequest> = Observable.create() { observer in
            let url = self.baseURL.appendingPathComponent(pathComponent)
            var request = URLRequest(url: url)
            let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true)!
            if method == "GET" {
                let queryItems = params.map { URLQueryItem(name: $0.0, value: $0.1) }
                
                urlComponents.queryItems = queryItems
            } else {
                
                let jsonData = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                request.httpBody = jsonData
            }
            
            request.url = urlComponents.url!
            request.httpMethod = method
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            observer.onNext(request)
            observer.onCompleted()
            return Disposables.create()
        }
        return request
    }
}
