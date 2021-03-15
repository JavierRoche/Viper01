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
    var coreDataProvider: CoreDataProvider
    
    
    // MARK: LifeCycle
    
    init (userDefaultsProvider: UserDefaultsProvider,
          remoteDataProvider: RemoteDataProvider,
          coreDataProvider: CoreDataProvider) {
        self.userDefaultsProvider = userDefaultsProvider
        self.remoteDataProvider = remoteDataProvider
        self.coreDataProvider = coreDataProvider
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
                
            }
        }
    }
    
    func isFavouriteChar(id: Int) -> Bool {
        return coreDataProvider.isFavourite(id: Int32(id))
    }
    
    func saveFavouriteChar(id: Int) {
        coreDataProvider.saveFavourite(id: id)
    }
    
    func deleteFavouriteChar(id: Int) {
        coreDataProvider.deleteFavourite(id: id)
    }
}
