//
//  PermissionsInteractor.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import Foundation
import PromiseKit
import CoreLocation

class PermissionsInteractor: NSObject, PermissionsInteractorContract {
    weak var output: PermissionsInteractorOutputContract?

    var userDefaultsProvider: UserDefaultsProvider
    var coreDataProvider: CoreDataProvider
    var permissionProvider = PermissionProvider()
    
    /// User loc
    var currentLocation: CLLocation?
    var permission: Permission?
    
    
    // MARK: LifeCycle
    
    init (userDefaultsProvider: UserDefaultsProvider,
          coreDataProvider: CoreDataProvider,
          permissionProvider: PermissionProvider) {
        self.userDefaultsProvider = userDefaultsProvider
        self.coreDataProvider = coreDataProvider
        self.permissionProvider = permissionProvider
    }
    
    
    // MARK: Public functions
    
    func saveLastUserView() {
        /// Save the last user view tapped
        userDefaultsProvider.saveUserView(view: 2)
    }
    
    func simulatedDataCreation() {
        if userDefaultsProvider.isFirstExecution() {
            coreDataProvider.dataMigration()
            userDefaultsProvider.setFirstExecution()
        }
    }
    
    func getPermissionList() -> [Permission] {
        guard let permissionList = coreDataProvider.selectPermissions() as? [Permission] else {
            return []
        }
        return permissionList
    }
    
    func requestForCameraPermission(permission: Permission) {
        permission.granted = false
        firstly {
            permissionProvider.isEnabledCameraPermission()
                
        }.done { isEnable in
            if isEnable {
                permission.granted = true
                self.output?.permissionRequested(permission: permission)
                    
            } else {
                self.permissionProvider.requestForCameraPermission().done { success in
                    if success {
                        permission.granted = true
                        self.output?.permissionRequested(permission: permission)
                            
                    } else {
                        self.output?.permissionRequested(permission: permission)
                    }
                        
                }.catch { _ in
                    self.output?.permissionRequested(permission: permission)
                }
            }
                
        }.catch { _ in
            self.output?.permissionRequested(permission: permission)
        }
    }
    
    func requestForLocationPermission(permission: Permission) {
        permission.granted = false
        self.permission = permission
        
        firstly {
            permissionProvider.isEnabledLocationPermission()
                
        }.done { isEnable in
            if isEnable {
                permission.granted = true
                self.output?.permissionRequested(permission: permission)
                    
            } else {
                /// README: Al responder por delegado no se puede definir como promesa
                self.permissionProvider.requestForLocationPermission(interactor: self)
            }
                
        }.catch { _ in
            self.output?.permissionRequested(permission: permission)
        }
    }
    
    func requestForPhotosLibraryPermission(permission: Permission) {
        permission.granted = false
        firstly {
            permissionProvider.isEnabledPhotosLibraryPermission()
                
        }.done { isEnable in
            if isEnable {
                permission.granted = true
                self.output?.permissionRequested(permission: permission)
                    
            } else {
                self.permissionProvider.requestForPhotosLibraryPermission().done { success in
                    if success {
                        permission.granted = true
                        self.output?.permissionRequested(permission: permission)
                            
                    } else {
                        self.output?.permissionRequested(permission: permission)
                    }
                        
                }.catch { _ in
                    self.output?.permissionRequested(permission: permission)
                }
            }
                
        }.catch { _ in
            self.output?.permissionRequested(permission: permission)
        }
    }
    
    func requestForBiometricPermission(permission: Permission) {
        permission.granted = false
        firstly {
            permissionProvider.isEnabledBiometricPermission()
                
        }.done { isEnable in
            if isEnable {
                self.permissionProvider.requestForBiometricPermission().done { success in
                    if success {
                        permission.granted = true
                        self.output?.permissionRequested(permission: permission)
                            
                    } else {
                        self.output?.permissionRequested(permission: permission)
                    }
                        
                }.catch { _ in
                    self.output?.permissionRequested(permission: permission)
                }
                    
            } else {
                self.output?.permissionRequested(permission: permission)
            }
                
        }.catch { _ in
            self.output?.permissionRequested(permission: permission)
        }
    }
}


// MARK: CLLocationManager Delegate

extension PermissionsInteractor: CLLocationManagerDelegate {
    /// User device execute this method on changing of location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        permission?.granted = true
        /// README:  ! 100% seguro usar !. Hubo que entrar en requestForLocationPermission
        output?.permissionRequested(permission: permission!)
        currentLocation = locations.first
        print("[]\(String(describing: currentLocation))")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("[]\(error)")
    }
}
