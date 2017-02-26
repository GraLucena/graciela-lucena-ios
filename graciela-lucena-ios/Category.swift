//
//  Category.swift
//  graciela-lucena-ios
//
//  Created by Graciela Lucena on 2/24/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import RealmSwift
import Unbox

class Category: Object, Unboxable {
    
    // MARK: - Properties
    dynamic var attributes: Attributes!

    // MARK: - Enums and Structs
    private struct JSONKey {
        static let attributes = "attributes"
    }
    
    // MARK: - Initializers
    required convenience init(unboxer: Unboxer) {
        self.init()
        
        attributes = unboxer.unbox(JSONKey.attributes)
    }
}
