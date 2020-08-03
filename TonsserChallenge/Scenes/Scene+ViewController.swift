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
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        switch self {
        case .home(let viewModel):
            let nc = storyboard.instantiateViewController(identifier: "Home") as! UINavigationController
            var vc = nc.viewControllers.first as! HomeViewController
            vc.bind(toViewModel: viewModel)
            return vc
        }
    }
}
