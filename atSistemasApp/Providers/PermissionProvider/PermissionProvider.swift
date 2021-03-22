//
//  PermissionProvider.swift
//  atSistemasApp
//
//  Created by APPLE on 22/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation
import AVFoundation
import CoreLocation
import PhotosUI
import LocalAuthentication
import PromiseKit

class PermissionProvider: PermissionProviderContract {
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        return manager
    }()
    lazy var context: LAContext = {
        let context = LAContext()
        return context
    }()
    
    /// User loc
    var currentLocation: CLLocation?
    var error: NSError?
    
    
    func isEnabledCameraPermission() -> Promise<Bool> {
        return Promise<Bool> { promise in
            promise.fulfill(AVCaptureDevice.authorizationStatus(for: AVMediaType.video) == .authorized ? true : false)
        }
    }
    
    func requestForCameraPermission() -> Promise<Bool> {
        return Promise<Bool> { promise in
            /// README: Accederiamos a la camara trasera con AVCaptureDevice y la intentariamos inicializar sobre un AVCaptureDeviceInput.
            /// Segun si queremos tomar una foto o, por ejemplo, leer un QR pues inicializariamos el output con imagen fija o video.
            /// En los metodos delegados AVCapturePhotoCaptureDelegate y/o AVCaptureVideoDataOutputSampleBufferDelegate
            /// nos llegarian las fotos o los frames de las fotos, respecticamente, con los que hariamos lo que necesitasemos.
            AVCaptureDevice.requestAccess(for: .video) { status in
                promise.fulfill(status ? true : false)
            }
        }
    }
    
    func isEnabledLocationPermission() -> Promise<Bool> {
        return Promise<Bool> { promise in
            promise.fulfill(CLLocationManager.authorizationStatus() == .authorizedAlways ||
                            CLLocationManager.authorizationStatus() == .authorizedWhenInUse ? true : false)
        }
    }
    
    func requestForLocationPermission(interactor: PermissionsInteractor) {
        /// Request permissions and activate search
        locationManager.delegate = interactor
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func isEnabledPhotosLibraryPermission() -> Promise<Bool> {
        return Promise<Bool> { promise in
            promise.fulfill(PHPhotoLibrary.authorizationStatus() == .authorized ? true : false)
        }
    }
    
    func requestForPhotosLibraryPermission() -> Promise<Bool> {
        return Promise<Bool> { promise in
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    promise.fulfill(true)
                    
                case .notDetermined, .denied, .restricted:
                    promise.fulfill(false)
                    
                @unknown default:
                    promise.fulfill(false)
                }
            }
        }
    }
    
    func isEnabledBiometricPermission() -> Promise<Bool> {
        return Promise<Bool> { promise in
            promise.fulfill(context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) ? true : false)
        }
    }
    
    func requestForBiometricPermission() -> Promise<Bool> {
        return Promise<Bool> { promise in
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: Constants.permissions) { success, _ in
                promise.fulfill(success)
            }
        }
    }
}
