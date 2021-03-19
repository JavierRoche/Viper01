//
//  CharComicsRequest.swift
//  atSistemasApp
//
//  Created by APPLE on 14/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

/// Request implementation to get char's comics
struct CharComicsRequest: APIRequest {
    typealias Response = CharComicsResponse
    
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "\(Constants.path)/\(self.id)/comics"
    }
    
    var parameters: [String : String] {
        var params: [String : String] = [:]
        params[Constants.ts] = Constants.tsValue
        params[Constants.apikey] = Constants.apikeyValue
        params[Constants.hash] = Constants.hashValue
        return params
    }
}

