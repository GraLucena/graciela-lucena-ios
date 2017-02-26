//
//  AppCoordinator.swift
//  graciela-lucena-ios
//
//  Created by Graciela Lucena on 2/24/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit
import RxSwift

class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    var rootViewController: UIViewController {
        let coordinator = coordinators.popFirst()!.1
        return coordinator.rootViewController
    }
    private var window: UIWindow
    private var coordinators: CoordinatorsDictionary
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializers
    init(window: UIWindow) {
        self.window = window
        coordinators = [:]
    }
    
    // MARK: - Coordinator
    func start() {
        //TODO:Decide if iPad or iPhone
        if (UI_USER_INTERFACE_IDIOM() == .Pad){
            iPadController()
        }else{
            iPhoneController()
        }
    }

    private func iPadController() {
        let coordinatorIpad = iPadCoordinator()
        coordinators[iPadCoordinator.name] = coordinatorIpad
        window.rootViewController = coordinatorIpad.rootViewController
        coordinatorIpad.start()
    }
    
    private func iPhoneController() {
        let coordinatorIphone = iPhoneCoordinator()
        coordinators[iPhoneCoordinator.name] = coordinatorIphone
        window.rootViewController = coordinatorIphone.rootViewController
        coordinatorIphone.start()
    }
}
