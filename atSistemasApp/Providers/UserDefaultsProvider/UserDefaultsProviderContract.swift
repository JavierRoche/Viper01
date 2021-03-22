//
//  UserDefaultsProviderContract.swift
//  atSistemasApp
//
//  Created by APPLE on 15/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

protocol UserDefaultsProviderContract {
    func saveUserView(view: Int)
    func setFirstExecution()
    func isFirstExecution() -> Bool
    func setFavourite(name: String)
    func isFavourite(name: String) -> Bool
    func deleteFavourite(name: String)
}
