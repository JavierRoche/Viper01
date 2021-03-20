//
//  KeyChainProvider.swift
//  atSistemasApp
//
//  Created by APPLE on 20/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

class KeyChainProvider: KeyChainProviderContract {
    // MARK: Public Functions
    
    /// Save credentials
    func save(email: String, password: String) -> String? {
        guard let passwordData = password.data(using: .utf8) else { return Constants.missingData}
        
        /// Security Framework needs a dictionary with data types
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: email,
                                    kSecValueData as String: passwordData]
        
        /// Add item with a OSStatus object
        let status: OSStatus = SecItemAdd(query as CFDictionary, nil)
        switch status {
        case errSecSuccess:
                return email
            
        default:
                return nil
        }
    }
    
    /// Load credentials
    func load(email: String, password: String) -> String? {
        guard let query: CFDictionary = createQuery(email: email) else { return nil }
        
        /// CF base object for requesting with an OSStatus
        var item: CFTypeRef?
        let status: OSStatus = SecItemCopyMatching(query, &item)
        switch status {
        case errSecSuccess:
            guard let itemData = item as? [String: Any],
                    let credentialsData = itemData[kSecValueData as String] as? Data,
                    let credentials = String(data: credentialsData, encoding: .utf8),
                    credentials == password else { return nil }
            return email
            
        case errSecItemNotFound:
            return nil
            
        default:
            return nil
        }
    }
    
    
    // MARK: Public Functions
    
    private func createQuery(email: String) -> CFDictionary? {
        /// Indicate stored data type in a key
        return [kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: email,
                kSecReturnAttributes as String: kCFBooleanTrue as Any,
                kSecReturnData as String: kCFBooleanTrue as Any] as CFDictionary
    }
}
