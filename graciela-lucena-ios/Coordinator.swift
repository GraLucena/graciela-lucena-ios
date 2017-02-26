//
//  Coordinator.swift
//  graciela-lucena-ios
//
//  Created by Graciela Lucena on 2/24/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import UIKit

typealias CoordinatorsDictionary = [String: Coordinator]

protocol Coordinator {
    var rootViewController: UIViewController { get }
    
    func start()
}

extension Coordinator {
    static var name: String {
        return String(self)
    }
}