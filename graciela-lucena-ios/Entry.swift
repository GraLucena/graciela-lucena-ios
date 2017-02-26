//
//  App.swift
//  graciela-lucena-ios
//
//  Created by Graciela Lucena on 2/24/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import RealmSwift
import Unbox

class Entry: Object, Unboxable {

    // MARK: - Properties
    dynamic var localId : String!
    dynamic var id : Identifier!
    dynamic var name : Name!
    var image = List<Image>()
    dynamic var summary: Summary!
    dynamic var price: Price!
    dynamic var rights: Right!
    dynamic var title: Title!
    dynamic var category: Category!
    dynamic var releaseDate: ReleaseDate!

    // MARK: - Enums and Structs
    private struct JSONKey {
        static let localId = "databaseId"
        static let id = "id"
        static let name = "im:name"
        static let image = "im:image"
        static let summary = "summary"
        static let price = "im:price"
        static let rights = "rights"
        static let title = "title"
        static let category = "category"
        static let releaseDate = "im:releaseDate"
    }

    // MARK: - Initializers
    required convenience init(unboxer: Unboxer) {
        self.init()
        
        id = unboxer.unbox(JSONKey.id)
        name = unboxer.unbox(JSONKey.name)
        let images: [Image]? = unboxer.unbox(JSONKey.image)
        if images != nil {
            self.image = List(images!)
        }
        summary = unboxer.unbox(JSONKey.summary)
        price = unboxer.unbox(JSONKey.price)
        rights = unboxer.unbox(JSONKey.rights)
        title = unboxer.unbox(JSONKey.title)
        category = unboxer.unbox(JSONKey.category)
        releaseDate = unboxer.unbox(JSONKey.releaseDate)
        localId = unboxer.unbox(JSONKey.localId) ?? id.attributes.id
    }
    
    // MARK: - Realm
    override static func primaryKey() -> String? {
        return "localId"
    }    
}