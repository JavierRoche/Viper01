//
//  MarvelListInteractor.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import Foundation
import PromiseKit

class MarvelListInteractor: MarvelListInteractorContract {
    weak var output: MarvelListInteractorOutputContract?

    var userDefaultsProvider: UserDefaultsProvider
    var remoteDataProvider: RemoteDataProvider
    
    
    // MARK: LifeCycle
    
    init (userDefaultsProvider: UserDefaultsProvider,
          remoteDataProvider: RemoteDataProvider) {
        self.userDefaultsProvider = userDefaultsProvider
        self.remoteDataProvider = remoteDataProvider
    }
    
    
    // MARK: Public Functions
    
    func saveLastUserView() {
        /// Save the last user view tapped
        userDefaultsProvider.saveUserView(view: 0)
    }
    
    func getMarvelList() -> Promise<[Character]> {
        return Promise<[Character]> { promise in
            firstly {
                remoteDataProvider.fetchAllChars()
                
            }.done { response in
                promise.fulfill(response)
                
            }.catch { error in
                promise.reject(error)
            }
        }
    }
    
    func saveFavouriteChar(name: String) {
        userDefaultsProvider.setFavourite(name: name)
    }
    
    func isFavouriteChar(name: String) -> Bool {
        return userDefaultsProvider.isFavourite(name: name)
    }
    
    func deleteFavouriteChar(name: String) {
        userDefaultsProvider.deleteFavourite(name: name)
    }
}
