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
    var keyChainProvider: KeyChainProvider
    
    
    // MARK: LifeCycle
    
    init (userDefaultsProvider: UserDefaultsProvider, keyChainProvider: KeyChainProvider) {
        self.userDefaultsProvider = userDefaultsProvider
        self.keyChainProvider = keyChainProvider
    }
    
    
    // MARK: Public functions
    
    /// Save the last user view tapped
    func saveLastUserView() {
        userDefaultsProvider.saveUserView(view: 1)
    }
    
    func saveCredentials(email: String, password: String) -> String? {
        return keyChainProvider.save(email: email, password: password)
    }
    
    func loadCredentials(email: String, password: String) -> String? {
        return keyChainProvider.load(email: email, password: password)
    }
}
