//
//  RemoteDataProviderContract.swift
//  atSistemasApp
//
//  Created by APPLE on 11/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation
import PromiseKit

protocol RemoteDataProviderContract {
    func fetchAllChars() -> Promise<[Character]>
    func fetchCharComics(charId: Int) -> Promise<[ComicDAO]>
}

