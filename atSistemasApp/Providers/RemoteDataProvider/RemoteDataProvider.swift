//
//  RemoteDataProvider.swift
//  atSistemasApp
//
//  Created by APPLE on 11/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

enum NetworkError: Error, LocalizedError {
    case badResponse
    case badData

    /// Localized description
    var localizedDescription: String {
        switch self {
        case .badResponse:
            return "network_error_parsing_description"
        case .badData:
            return "network_error_bad_data"
        }
    }
}

class RemoteDataProvider: RemoteDataProviderContract {
    /// Alamofire session
    private lazy var session: Session = {
        var configuration = URLSessionConfiguration.af.default
        let session = Session(configuration: configuration)
        return session
    }()
    
    
    // MARK: Public Functions
    
    func fetchAllChars() -> Promise<[Character]> {
        let request = AllCharsRequest()
        
        return Promise<[Character]> { promise in
            session.request(request.getRequest())
                .validate(contentType: Constants.contentTypeValue)
                .responseDecodable(of: AllCharsResponse.self) { response in
                
                if let httpResponse = response.response, httpResponse.statusCode >= 400 && httpResponse.statusCode < 500 {
                    promise.reject(NetworkError.badResponse)
                    return
                }
                    
                do {
                    let charList = try response.result.get().data.results as [Character]
                    promise.fulfill(charList)

                } catch {
                    promise.reject(NetworkError.badData)
                }
            }
        }
    }
    
    func fetchCharComics(charId: Int) -> Promise<[Comic]> {
        let request = CharComicsRequest(id: charId)
        
        return Promise<[Comic]> { promise in
            session.request(request.getRequest())
                .validate(contentType: Constants.contentTypeValue)
                .responseDecodable(of: CharComicsResponse.self) { (response) in
                
                if let httpResponse = response.response, httpResponse.statusCode >= 400 && httpResponse.statusCode < 500 {
                    promise.reject(NetworkError.badResponse)
                    return
                }
                    
                do {
                    let comicList = try response.result.get().data.results as [Comic]
                    promise.fulfill(comicList)

                } catch {
                    print("Bad data response")
                    promise.reject(NetworkError.badData)
                }
            }
        }
    }
}

