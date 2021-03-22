//
//  PermissionState.swift
//  atSistemasApp
//
//  Created by APPLE on 18/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

enum PermissionState: Int {
    case todo = 0
    case done
}

enum PermissionType: String {
    case camera
    case location
    case photosLibrary
    case biometric
    
    var localizedString: String {
        switch self {
        case .camera:
            return Constants.camera
            
        case .location:
            return Constants.location
            
        case .photosLibrary:
            return Constants.photosLibrary
            
        case .biometric:
            return Constants.biometric
        }
    }
}

enum PermissionInfo: String {
    case authorized
    case notAuthorized
    
    var localizedString: String {
        switch self {
        case .authorized:
            return Constants.authorized
            
        case .notAuthorized:
            return Constants.notAuthorized
        }
    }
}
