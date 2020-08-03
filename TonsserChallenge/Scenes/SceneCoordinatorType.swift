//
//  SceneCoordinatorType.swift
//  TonsserChallenge
//
//  Created by Harri on 8/3/20.
//  Copyright © 2020 Tonsser. All rights reserved.
//

import UIKit
import RxSwift

protocol SceneCoordinatorType {
    func transition(to scene: Scene, type: SceneTransitionType) -> Completable
    
    func pop(animated: Bool) -> Completable
}

extension SceneCoordinatorType {
    func pop() -> Completable {
        return pop(animated: true)
    }
}


