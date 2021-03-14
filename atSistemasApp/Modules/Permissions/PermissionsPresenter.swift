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

    }

    func viewWillAppear() {
        interactor.saveLastUserView()
    }
}


// MARK: - PermissionsInteractorOutputContract

extension PermissionsPresenter: PermissionsInteractorOutputContract {
    
}


// MARK: - PermissionsWireframeOutputContract

extension PermissionsPresenter: PermissionsWireframeOutputContract {
    
}
