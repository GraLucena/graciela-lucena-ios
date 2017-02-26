//
//  Title.swift
//  graciela-lucena-ios
//
//  Created by Graciela Lucena on 2/24/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import RealmSwift
import Unbox

class Title: Object, Unboxable {
    
    // MARK: - Properties
    dynamic var title: String!
    
    // MARK: - Enums and Structs
    private struct JSONKey {
        static let label = "label"
    }
    
    // MARK: - Initializers
    required convenience init(unboxer: Unboxer) {
        self.init()
        
        title = unboxer.unbox(JSONKey.label)
    }
}