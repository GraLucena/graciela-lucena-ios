//
//  AppsDiskService.swift
//  graciela-lucena-ios
//
//  Created by Graciela Lucena on 2/24/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm
import Unbox

struct AppsDiskService {

    private static let disposeBag = DisposeBag()

    // MARK: - Properties
    private static var realm: Realm {
        return try! Realm()
    }

    // MARK: - API
    static func readApps() -> Observable<[Entry]> {
        
        let realmEntries = realm.objects(Entry.self)
        
        return realmEntries
            .asObservableArray()
            .map { (apps) -> [Entry] in
                
                return apps
        }
    }
    
    static func save(apps: [Entry]) -> Observable<Bool> {
        
        do {
            realm.beginWrite()
            realm.add(apps, update: true)
            try realm.commitWrite()
            return Observable.just(true)
        } catch {
            return Observable.just(false)
        }
    }

    static func readCategories() -> [String] {
        
        let realmEntries = realm.objects(Entry.self)
        var categories = [String]()
        
        for entry in realmEntries {
            categories.append(entry.category.attributes.label!)
        }
        return Array(Set(categories))
    }

}
