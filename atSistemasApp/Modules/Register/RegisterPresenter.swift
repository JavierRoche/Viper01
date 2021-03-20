//
//  RegisterPresenter.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import UIKit

class RegisterPresenter: RegisterPresenterContract {
    weak var view: RegisterViewContract!
    var interactor: RegisterInteractorContract!
    var entity: RegisterEntityContract?
    var wireframe: RegisterWireframeContract?

    
    // MARK: Public Functions
    
    func viewDidLoad() {}

    func viewWillAppear() {
        interactor.saveLastUserView()
    }
    
    func badDataIntput(message: String) {
        let action = UIAlertAction(title: Constants.accept, style: .default, handler: nil)
        wireframe?.showErrorModalAlert(view, content: message, customActions: [action], completion: nil)
    }
}


// MARK: - RegisterInteractorOutputContract

extension RegisterPresenter: RegisterInteractorOutputContract {}


// MARK: - RegisterWireframeOutputContract

extension RegisterPresenter: RegisterWireframeOutputContract {}
