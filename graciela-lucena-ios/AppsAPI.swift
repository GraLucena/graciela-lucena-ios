//
//  AppsAPI.swift
//  graciela-lucena-ios
//
//  Created by Graciela Lucena on 2/24/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

struct AppsAPI {
    
    private static let disposeBag = DisposeBag()
    
    static func readApps() -> Observable<[Entry]> {
        
        AppsNetworkService.readApps()
            .subscribeNext { (apps) in
                
                saveApps(apps)
                    .subscribe()
                    .addDisposableTo(disposeBag)
            }
            .addDisposableTo(disposeBag)
        
        return AppsDiskService.readApps()
    }
    
    
    private static func saveApps(apps: [Entry]) -> Observable<Bool> {
        
        return AppsDiskService.save(Array(apps))
    }
    
    static func getCategories() -> [String] {
        
        return AppsDiskService.readCategories()
    }

}
