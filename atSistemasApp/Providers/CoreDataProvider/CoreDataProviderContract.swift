//
//  CoreDataProviderContract.swift
//  atSistemasApp
//
//  Created by APPLE on 13/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

protocol CoreDataProviderContract {
    func saveFavourite(id: Int)
    func deleteFavourite(id: Int)
    func isFavourite(id: Int32) -> Bool
}
