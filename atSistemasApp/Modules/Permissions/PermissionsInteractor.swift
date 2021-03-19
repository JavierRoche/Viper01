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

class PermissionsInteractor: PermissionsInteractorContract {
    weak var output: PermissionsInteractorOutputContract?

    var userDefaultsProvider: UserDefaultsProvider
    var coreDataProvider: CoreDataProvider
    
    
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
        /// Evaluate video camera suthorization state
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
}
