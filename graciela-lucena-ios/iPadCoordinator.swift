//
//  iPadCoordinator.swift
//  graciela-lucena-ios
//
//  Created by Graciela Lucena on 2/24/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit
import RxSwift

class iPadCoordinator: Coordinator {
    
    // MARK: - Properties
    var rootViewController: UIViewController
    private var coordinators: [String: Coordinator]
    private var navigationController: UINavigationController {
        return rootViewController as! UINavigationController
    }
    
    // MARK: - Initializers
    init() {
        rootViewController = UINavigationController()
        coordinators = [:]
    }
    
    // MARK: - Coordinator
    func start() {
        showiPadViewController()
    }
    
    // MARK: - Utils
    private func showiPadViewController() {
        let ipadVC = iPadViewController()
        ipadVC.coordinator = self
        navigationController.setViewControllers([ipadVC], animated: true)
    }
    
    func showAppDetail(app: Entry) {
        let appDetailVC = AppDetailViewController(app: app)
        navigationController.pushViewController(appDetailVC, animated: true)
    }
    
    func show(categories: [String]) {
        let categoriesVC = CategoriesViewController(categories: categories)
        navigationController.pushViewController(categoriesVC, animated: true)
    }
}

// MARK: - iPadCoodinator
extension iPadCoordinator: iPadCoodinator {
    func userDidPressShowAppDetail(app: Entry) {
        showAppDetail(app)
    }
    
    func userDidPressShowCategories(categories: [String]) {
        show(categories)
    }
}
