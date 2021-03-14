//
//  RegisterInteractor.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import Foundation

class RegisterInteractor: RegisterInteractorContract {
    weak var output: RegisterInteractorOutputContract?

    var userDefaultsProvider: UserDefaultsProvider
    
    
    // MARK: LifeCycle
    
    init (provider: UserDefaultsProvider) {
        self.userDefaultsProvider = provider
    }
    
    
    // MARK: Public functions
    
    func saveLastUserView() {
        /// Save the last user view tapped
        userDefaultsProvider.saveUserView(view: 1)
    }
}
