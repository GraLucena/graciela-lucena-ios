//
//  Image.swift
//  graciela-lucena-ios
//
//  Created by Graciela Lucena on 2/24/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import RealmSwift
import Unbox

class Image: Object, Unboxable {
    
    // MARK: - Properties
    dynamic var imageURL: String!

    // MARK: - Enums and Structs
    private struct JSONKey {
        static let label = "label"
    }
    
    // MARK: - Initializers
    required convenience init(unboxer: Unboxer) {
        self.init()
        
        imageURL = unboxer.unbox(JSONKey.label)
    }
}
