//
//  PermissionsInteractor.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import Foundation
import AVFoundation
import CoreLocation
import PhotosUI

class PermissionsInteractor: NSObject, PermissionsInteractorContract {
    weak var output: PermissionsInteractorOutputContract?

    var userDefaultsProvider: UserDefaultsProvider
    var coreDataProvider: CoreDataProvider
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    /// User loc
    var currentLocation: CLLocation?
    var permission: Permission?
    
    
    // MARK: LifeCycle
    
    init (userDefaultsProvider: UserDefaultsProvider,
          coreDataProvider: CoreDataProvider) {
        self.userDefaultsProvider = userDefaultsProvider
        self.coreDataProvider = coreDataProvider
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
        /// Evaluate video camera authorization state
        DispatchQueue.main.async { [weak self] in
            switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
            case .authorized:
                /// README: Accederiamos a la camara trasera con AVCaptureDevice y la intentariamos inicializar sobre un AVCaptureDeviceInput. Segun si queremos tomar una foto o, por ejemplo, leer un QR pues inicializariamos el output con imagen fija o video. En los metodos delegados AVCapturePhotoCaptureDelegate y/o AVCaptureVideoDataOutputSampleBufferDelegate nos llegarian las fotos o los frames de las fotos, respecticamente, con los que hariamos lo que necesitasemos.
                permission.granted = true
                self?.output?.cameraPermissionRequested(permission: permission)
                
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { status in
                    if status == true {
                        permission.granted = true
                        self?.output?.cameraPermissionRequested(permission: permission)
                        /// README: mismo comentario que .authorized
                        
                    } else {
                        permission.granted = false
                        self?.output?.cameraPermissionRequested(permission: permission)
                    }
                }
                
            default:
                permission.granted = false
                self?.output?.cameraPermissionRequested(permission: permission)
            }
        }
    }
    
    func requestForLocationPermission(permission: Permission) {
        self.permission = permission
        
        /// Evaluate geo location authorization state
        DispatchQueue.main.async { [weak self] in
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways, .authorizedWhenInUse:
                permission.granted = true
                self?.output?.locationPermissionRequested(permission: permission)
            
            case .notDetermined:
                /// Request permissions and activate search
                self?.locationManager.requestAlwaysAuthorization()
                self?.locationManager.startUpdatingLocation()
                
            default:
                permission.granted = false
                self?.output?.locationPermissionRequested(permission: permission)
            }
        }
    }
    
    func requestForPhotosLibraryPermission(permission: Permission) {
        /// Evaluate photos library authorization state
        DispatchQueue.main.async { [weak self] in
            PHPhotoLibrary.requestAuthorization({ status in
                switch status {
                    case .authorized:
                        permission.granted = true
                        self?.output?.locationPermissionRequested(permission: permission)
                    
                    default:
                        permission.granted = false
                        self?.output?.locationPermissionRequested(permission: permission)
                }
            })
        }
    }
}


// MARK: CLLocationManager Delegate

extension PermissionsInteractor: CLLocationManagerDelegate {
    /// User device execute this method on changing of location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        permission?.granted = true
        output?.locationPermissionRequested(permission: permission!)
        currentLocation = locations.first
        print("[]\(String(describing: currentLocation))")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("[]\(error)")
    }
}
