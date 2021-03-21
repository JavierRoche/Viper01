//
//  AllCharsRequest.swift
//  atSistemasApp
//
//  Created by APPLE on 11/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

struct AllCharsRequest: APIRequest {
    typealias Response = AllCharsResponse
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return Constants.path
    }
    
    var parameters: [String: String] {
        var params: [String: String] = [:]
        
        guard let path = Bundle.main.path(forResource: Constants.preferences, ofType: Constants.plist),
            let xml = FileManager.default.contents(atPath: path),
            let preferences = try? PropertyListDecoder().decode(APIKeys.self, from: xml) else { return params }
        
        params[Constants.ts] = preferences.tsValue
        params[Constants.apikey] = preferences.apikeyValue
        params[Constants.hash] = preferences.hashValue
        return params
    }
}
