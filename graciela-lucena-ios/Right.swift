//
//  Right.swift
//  graciela-lucena-ios
//
//  Created by Graciela Lucena on 2/24/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import RealmSwift
import Unbox

class Right: Object, Unboxable {
    
    // MARK: - Properties
    dynamic var rights: String!
    
    // MARK: - Enums and Structs
    private struct JSONKey {
        static let label = "label"
    }
    
    // MARK: - Initializers
    required convenience init(unboxer: Unboxer) {
        self.init()
        
        rights = unboxer.unbox(JSONKey.label)
    }
}
