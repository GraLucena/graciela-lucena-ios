//
//  iPhoneCoordinator.swift
//  graciela-lucena-ios
//
//  Created by Graciela Lucena on 2/24/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit
import RxSwift

class iPhoneCoordinator: Coordinator {

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
        showiPhoneViewController()
    }
    
    // MARK: - Utils
    private func showiPhoneViewController() {
        let iphoneVC = iPhoneViewController()
        iphoneVC.coordinator = self
        navigationController.setViewControllers([iphoneVC], animated: true)
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

// MARK: - iPhoneCoodinator
extension iPhoneCoordinator: iPhoneCoodinator {
    func userDidPressShowAppDetail(app: Entry) {
        showAppDetail(app)
    }
    
    func userDidPressShowCategories(categories: [String]) {
        show(categories)
    }
}
