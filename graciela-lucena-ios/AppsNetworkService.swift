//
//  AppsNetworkService.swift
//  graciela-lucena-ios
//
//  Created by Graciela Lucena on 2/24/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import Unbox

struct AppsNetworkService {

    static func readApps() -> Observable<[Entry]> {
        
        return Observable.create { (observer) -> Disposable in
            
            Alamofire.request(Router.GetApps())
                .validate()
                .responseJSON { (response) in
                    
                    
                    switch response.result {
                    case .Success(let jsonData):
                        
                        guard let feed = jsonData["feed"] else {return}

                        guard let apps: [Entry] = try? Unbox(feed as! UnboxableDictionary, at: "entry") else {
                            break
                        }
                        
                        observer.onNext(apps)
                        observer.onCompleted()
                        
                    case .Failure(let error):
                        observer.onError(error)
                    }
            }
            
            return NopDisposable.instance
        }
    }


}