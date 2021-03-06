//
//  ReleaseDate.swift
//  graciela-lucena-ios
//
//  Created by Graciela Lucena on 2/25/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import RealmSwift
import Unbox

class ReleaseDate: Object, Unboxable {
    
    // MARK: - Properties
    dynamic var label: String!
    dynamic var attributes: Attributes!
    
    // MARK: - Enums and Structs
    private struct JSONKey {
        static let label = "label"
        static let attributes = "attributes"
    }
    
    // MARK: - Initializers
    required convenience init(unboxer: Unboxer) {
        self.init()
        
        label = unboxer.unbox(JSONKey.label)
        attributes = unboxer.unbox(JSONKey.attributes)
    }
}
