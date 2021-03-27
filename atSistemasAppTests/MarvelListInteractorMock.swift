//
//  MarvelListInteractorMock.swift
//  atSistemasAppTests
//
//  Created by APPLE on 22/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

@testable import PromiseKit
@testable import atSistemasApp

final class MarvelListInteractorMock: MarvelListInteractorContract {
    var output: MarvelListInteractorOutputContract?
    
    var emptyCharList = [Character]()
    var userDefaultsProvider = UserDefaultsProvider()
    
    func saveLastUserView() {
        userDefaultsProvider.saveUserView(view: 2)
    }
    
    func getMarvelList() -> Promise<[Character]> {
        return Promise<[Character]> { promise in
            promise.fulfill(emptyCharList)
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
