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
    
    func saveLastUserView() {}
    func saveFavouriteChar(name: String) {}
    func isFavouriteChar(name: String) -> Bool { return false }
    func deleteFavouriteChar(name: String) {}
    
    var emptyCharList = [Character]()
    /*var emptyCharList: Promise<[Character]> = {
        return Promise<[Character]> { promise in
            promise.fulfill([])
        }
    }()*/
    
    func getMarvelList() -> Promise<[Character]> {
        return Promise<[Character]> { promise in
            promise.fulfill(emptyCharList)
        }
    }
}
