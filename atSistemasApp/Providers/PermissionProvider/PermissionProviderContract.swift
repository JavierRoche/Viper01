//
//  PermissionProviderContract.swift
//  atSistemasApp
//
//  Created by APPLE on 22/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation
import PromiseKit

protocol PermissionProviderContract {
    func isEnabledCameraPermission() -> Promise<Bool>
    func requestForCameraPermission() -> Promise<Bool>
    func isEnabledLocationPermission() -> Promise<Bool>
    func requestForLocationPermission(interactor: PermissionsInteractor)
    func isEnabledPhotosLibraryPermission() -> Promise<Bool>
    func requestForPhotosLibraryPermission() -> Promise<Bool>
    func isEnabledBiometricPermission() -> Promise<Bool>
    func requestForBiometricPermission() -> Promise<Bool>
}
