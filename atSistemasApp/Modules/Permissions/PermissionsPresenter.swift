//
//  PermissionsPresenter.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import Foundation

class PermissionsPresenter: PermissionsPresenterContract {
    weak var view: PermissionsViewContract!
    var interactor: PermissionsInteractorContract!
    var entity: PermissionsEntityContract?
    var wireframe: PermissionsWireframeContract?

    
    // MARK: Public Functions
    
    func viewDidLoad() {
        interactor.simulatedDataCreation()
    }

    func viewWillAppear() {
        interactor.saveLastUserView()
        view.permissionListDidChange(permissionList: interactor.getPermissionList())
    }
    
    func requestForCameraPermission(permission: Permission) {
        interactor.requestForCameraPermission(permission: permission)
    }
    
    func requestForLocationPermission(permission: Permission) {
        interactor.requestForLocationPermission(permission: permission)
    }
    
    func requestForPhotosLibraryPermission(permission: Permission) {
        interactor.requestForPhotosLibraryPermission(permission: permission)
    }
    
    func requestForBiometricPermission(permission: Permission) {
        interactor.requestForBiometricPermission(permission: permission)
    }
}


// MARK: - PermissionsInteractorOutputContract

extension PermissionsPresenter: PermissionsInteractorOutputContract {
    func permissionRequested(permission: Permission) {
        view.permissionRequested(permission: permission)
    }
}


// MARK: - PermissionsWireframeOutputContract

extension PermissionsPresenter: PermissionsWireframeOutputContract {}
