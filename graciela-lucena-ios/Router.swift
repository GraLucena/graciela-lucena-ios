//
//  Router.swift
//  graciela-lucena-ios
//
//  Created by Graciela Lucena on 2/24/17.
//  Copyright © 2017 Graciela Lucena. All rights reserved.
//

import Foundation
import Alamofire

typealias JSONDictionary = [String: AnyObject]


enum Router: URLRequestConvertible {
    
    private struct Request {
        let method: Alamofire.Method
        let path: String
        let encoding: ParameterEncoding?
        let parameters: JSONDictionary?
        
        init(method: Alamofire.Method,
             path: String,
             encoding: ParameterEncoding? = nil,
             parameters: JSONDictionary? = nil){
            
            self.method = method
            self.path = path
            self.encoding = encoding
            self.parameters = parameters
        }
    }
    
    static let baseHostPath = "https://itunes.apple.com/us/rss"
    static let reachabilityPath = "https://www.google.com"

    var baseURLPath: String {
        
        return "\(Router.baseHostPath)"
    }

    case GetApps()
    
    private var request: Request {
        switch self {
        case .GetApps():
            return Request(method: .GET,
                           path: "/topfreeapplications/limit=20/json")
        }
    }
    
    var URLRequest: NSMutableURLRequest {
        
        let URL = NSURL(string: baseURLPath)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(request.path))
        mutableURLRequest.HTTPMethod = request.method.rawValue
        
        mutableURLRequest.timeoutInterval = NSTimeInterval(10 * 1000)
        
        if let encoding = request.encoding {
            return encoding.encode(mutableURLRequest, parameters: request.parameters).0
        } else {
            return mutableURLRequest
        }
    }
}