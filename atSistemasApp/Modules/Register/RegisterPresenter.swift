//
//  RegisterPresenter.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import Foundation

class RegisterPresenter: RegisterPresenterContract {
    weak var view: RegisterViewContract!
    var interactor: RegisterInteractorContract!
    var entity: RegisterEntityContract?
    var wireframe: RegisterWireframeContract?

    
    // MARK: Public Functions
    
    func viewDidLoad() {

    }

    func viewWillAppear() {
        interactor.saveLastUserView()
    }
}


// MARK: - RegisterInteractorOutputContract

extension RegisterPresenter: RegisterInteractorOutputContract {
    
}


// MARK: - RegisterWireframeOutputContract

extension RegisterPresenter: RegisterWireframeOutputContract {
    
}
