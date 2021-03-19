//
//  CoreDataProviderContract.swift
//  atSistemasApp
//
//  Created by APPLE on 13/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataProviderContract {
    func selectPermissions() -> [NSManagedObject]?
    func dataMigration()
}
