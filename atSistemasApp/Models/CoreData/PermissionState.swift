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
    case camera = "camera"
}

enum PermissionInfo: String {
    case authorized = "Authorized"
    case notAuthorized = "Not authorized"
}
