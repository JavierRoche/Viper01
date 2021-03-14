//
//  UserDefaultsProvider.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

class UserDefaultsProvider {
    private let keyUserView = "keyUserView"

    
    // MARK: Public Functions
    
    func saveUserView(view: Int) {
        UserDefaults.standard.set(view, forKey: keyUserView)
    }
    
    func loadUserView() -> Int {
        if UserDefaults.standard.dictionaryRepresentation().keys.contains(keyUserView) {
            return UserDefaults.standard.integer(forKey: keyUserView)
            
        } else {
            return 0
        }
    }
}
