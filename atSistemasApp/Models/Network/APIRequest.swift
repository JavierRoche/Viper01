//
//  APIRequest.swift
//  atSistemasApp
//
//  Created by APPLE on 12/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

enum Method: String, CaseIterable {
    case GET
    case POST
    case PUT
    case DELETE
}

protocol APIRequest {
    associatedtype Response: Codable
    var method: Method { get }
    var path: String { get }
    var parameters: [String: String] { get }
}


// MARK: APIRequest Implementation

extension APIRequest {
    /// URL base validated
    var baseURL: URL {
        guard let baseURL: URL = URL(string: Constants.apiURL) else {
            fatalError(Constants.invalidUrl)
        }
        return baseURL
    }
    
    
    // MARK: Functions
    
    /// Build definitive URL
    func getRequest() -> URLRequest {
        /// Add the path of the end point
        let url: URL = baseURL.appendingPathComponent(path)
        
        /// RFC 3986 check initialize
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            fatalError(Constants.componentsError)
        }
        
        /// Add parameters if exits
        if !parameters.isEmpty {
            components.queryItems = parameters.map {
                URLQueryItem(name: $0, value: $1)
            }
        }
        
        guard let finalURL = components.url else {
            fatalError(Constants.finalURLError)
        }
        
        /// Construct URLRequest with URL and add method
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        
        return request
    }
}
