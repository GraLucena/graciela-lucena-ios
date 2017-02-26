//
//  Attributes.swift
//  graciela-lucena-ios
//
//  Created by Graciela Lucena on 2/24/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import RealmSwift
import Unbox

class Attributes: Object, Unboxable {
    
    // MARK: - Properties
    dynamic var id: String?
    dynamic var label: String?
    dynamic var amount: String?
    dynamic var currency: String?

    // MARK: - Enums and Structs
    private struct JSONKey {
        static let id = "im:id"
        static let label = "label"
        static let amount = "amount"
        static let currency = "currency"

    }
    
    // MARK: - Initializers
    required convenience init(unboxer: Unboxer) {
        self.init()
        
        id = unboxer.unbox(JSONKey.id)
        label = unboxer.unbox(JSONKey.label)
        amount = unboxer.unbox(JSONKey.amount)
        currency = unboxer.unbox(JSONKey.currency)
    }
    
    // MARK: - Realm
    override static func primaryKey() -> String? {
        return "id"
    }
}
