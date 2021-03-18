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
            return Constants.apiBadResponse
        case .badData:
            return Constants.apiBadData
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
            session.request(request.getRequest()).validate(contentType: Constants.contentTypeValue)
                .responseDecodable(of: AllCharsResponse.self) { response in
                
                switch response.result {
                case .success(_):
                    do {
                        let charList = try response.result.get().data.results as [Character]
                        promise.fulfill(charList)

                    } catch {
                        promise.reject(NetworkError.badData)
                    }

                case .failure(_):
                    promise.reject(NetworkError.badResponse)
                }
            }
        }
    }
    
    func fetchCharComics(charId: Int) -> Promise<[ComicDAO]> {
        let request = CharComicsRequest(id: charId)
        
        return Promise<[ComicDAO]> { promise in
            session.request(request.getRequest()).validate(contentType: Constants.contentTypeValue)
                .responseJSON { response in
                
                switch response.result {
                case .success(_):
                    do {
                        if let responseDic = try response.result.get() as? [String: Any],
                            let dataKeyDic = responseDic[Constants.keyData] as? [String: Any],
                            let resultsKeyDic = dataKeyDic[Constants.keyResults] as? [[String: Any]] {
                            
                            var comicDAOList: [ComicDAO] = []
                            for comicDic in resultsKeyDic {
                                let comicDAO: ComicDAO = try ComicDAO(JSON: comicDic)
                                comicDAOList.append(comicDAO)
                            }
                            promise.fulfill(comicDAOList)
                        }

                    } catch {
                        print("Bad data response")
                        promise.reject(NetworkError.badData)
                    }

                case .failure(_):
                    promise.reject(NetworkError.badResponse)
                }
            }
        }
    }
}

