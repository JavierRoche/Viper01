//
//  PermissionsContract.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import UIKit

protocol PermissionsEntityContract {
    
}

protocol PermissionsInteractorContract {
    var output: PermissionsInteractorOutputContract? {get set}
    
    func saveLastUserView()
    func simulatedDataCreation()
    func getPermissionList() -> [Permission]
    func requestForCameraPermission(permission: Permission)
    func requestForLocationPermission(permission: Permission)
    func requestForPhotosLibraryPermission(permission: Permission)
    func requestForBiometricPermission(permission: Permission)
}

protocol PermissionsInteractorOutputContract: class {
    func permissionRequested(permission: Permission)
}

protocol PermissionsPresenterContract {
    var view: PermissionsViewContract! { get set }
    var interactor: PermissionsInteractorContract! { get set }
    var entity: PermissionsEntityContract? { get set }
    var wireframe: PermissionsWireframeContract? { get set }

    func viewDidLoad()
    func viewWillAppear()
    func requestForCameraPermission(permission: Permission)
    func requestForLocationPermission(permission: Permission)
    func requestForPhotosLibraryPermission(permission: Permission)
    func requestForBiometricPermission(permission: Permission)
}

protocol PermissionsViewContract: BaseViewController {
    var presenter: PermissionsPresenterContract! { get set }
    
    func permissionListDidChange(permissionList: [Permission])
    func permissionRequested(permission: Permission)
}

protocol PermissionsWireframeContract: BaseWireframe {
    var output: PermissionsWireframeOutputContract? { get set }
    var view: UIViewController! { get set }
}

protocol PermissionsWireframeOutputContract: class {

}
