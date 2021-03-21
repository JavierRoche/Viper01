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
    
    var parameters: [String: String] {
        var params: [String: String] = [:]
        
        guard let path = Bundle.main.path(forResource: "Preferences", ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path),
            let preferences = try? PropertyListDecoder().decode(APIKeys.self, from: xml) else { return params }
        
        params[Constants.ts] = preferences.tsValue
        params[Constants.apikey] = preferences.apikeyValue
        params[Constants.hash] = preferences.hashValue
        return params
    }
}
