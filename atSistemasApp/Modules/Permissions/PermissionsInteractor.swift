//
//  PermissionsInteractor.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import Foundation

class PermissionsInteractor: PermissionsInteractorContract {
    weak var output: PermissionsInteractorOutputContract?

    var userDefaultsProvider: UserDefaultsProvider
    var coreDataProvider: CoreDataProvider
    
    
    // MARK: LifeCycle
    
    init (userDefaultsProvider: UserDefaultsProvider,
          coreDataProvider: CoreDataProvider) {
        self.userDefaultsProvider = userDefaultsProvider
        self.coreDataProvider = coreDataProvider
    }
    
    
    // MARK: Public functions
    
    func saveLastUserView() {
        /// Save the last user view tapped
        userDefaultsProvider.saveUserView(view: 2)
    }
    
    func simulatedDataCreation() {
        if userDefaultsProvider.isFirstExecution() {
            coreDataProvider.dataMigration()
            userDefaultsProvider.setFirstExecution()
        }
    }
    
    func getPermissionList() -> [Permission] {
        guard let permissionList = coreDataProvider.selectPermissions() as? [Permission] else {
            return []
        }
        return permissionList
    }
}
