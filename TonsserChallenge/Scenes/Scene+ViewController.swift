//
//  Scene+ViewController.swift
//  TonsserChallenge
//
//  Created by Harri on 8/3/20.
//  Copyright © 2020 Tonsser. All rights reserved.
//

import Foundation
import UIKit

extension Scene {
    
    func viewController() -> UIViewController {
        switch self {
        case .home(let viewModel):
            var viewController = HomeViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            viewController.bind(toViewModel: viewModel)
            return navigationController
        }
    }
}
