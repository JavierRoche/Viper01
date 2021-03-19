//
//  UserDefaultsProvider.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

class UserDefaultsProvider: UserDefaultsProviderContract {
    private let keyUserView = Constants.keyUserView
    private let keyFavourite = Constants.keyFavourite
    private let keyFirstExecution = Constants.keyFirstExecution

    
    // MARK: User View
    
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
    
    
    // MARK: Simulated Data Load
    
    func setFirstExecution() {
        UserDefaults.standard.set(false, forKey: keyFirstExecution)
    }
    
    func isFirstExecution() -> Bool {
        if UserDefaults.standard.dictionaryRepresentation().keys.contains(keyFirstExecution) {
            return UserDefaults.standard.bool(forKey: keyFirstExecution)
            
        } else {
            return true
        }
    }
    
    
    // MARK: Favourites
    
    func setFavourite(name: String) {
        UserDefaults.standard.set(true, forKey: name)
    }
    
    func isFavourite(name: String) -> Bool {
        if UserDefaults.standard.dictionaryRepresentation().keys.contains(name) {
            return UserDefaults.standard.bool(forKey: name)
            
        } else {
            return false
        }
    }
    
    func deleteFavourite(name: String) {
        if UserDefaults.standard.dictionaryRepresentation().keys.contains(name) {
            UserDefaults.standard.removeObject(forKey: name)
        }
    }
}
