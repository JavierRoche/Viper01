//
//  MarvelDetailInteractor.swift
//  atSistemasApp
//
//  Created by APPLE on 14/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import Foundation
import PromiseKit

class MarvelDetailInteractor: MarvelDetailInteractorContract {
    weak var output: MarvelDetailInteractorOutputContract?

    private var remoteDataProvider: RemoteDataProvider
    private var char: Character
    
    
    // MARK: LifeCycle
    
    init (provider: RemoteDataProvider, char: Character) {
        self.remoteDataProvider = provider
        self.char = char
    }
    
    
    // MARK: Public Functions
    
    func getChar() -> Character {
        return self.char
    }
    
    func getComicList() -> Promise<[Comic]> {
        return Promise<[Comic]> { promise in
            firstly {
                remoteDataProvider.fetchCharComics(charId: char.id ?? 0)
                
            }.done { response in
                let comicList = response.map ({
                    
                    Comic(comicDAO: $0)
                })
                promise.fulfill(comicList)
                
            }.catch { error in
                promise.reject(error)
            }
        }
    }
}
