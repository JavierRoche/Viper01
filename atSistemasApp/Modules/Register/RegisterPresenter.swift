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

    let action = UIAlertAction(title: Constants.accept, style: .default, handler: nil)
    
    
    // MARK: Public Functions
    
    func viewDidLoad() {}

    func viewWillAppear() {
        interactor.saveLastUserView()
    }
    
    func badDataIntput(message: String) {
        wireframe?.showErrorModalAlert(view, content: message, customActions: [action], completion: nil)
    }
    
    func saveCredentials(email: String, password: String) -> Bool {
        if interactor.saveCredentials(email: email, password: password) != nil {
            wireframe?.showErrorModalAlert(view, content: "\(Constants.couldntSaveCredentials)\(email)", customActions: [action], completion: nil)
            return false
        }
        return true
    }
    
    func loadCredentials(email: String, password: String) -> String {
        guard let emailRetrieve = interactor.loadCredentials(email: email, password: password) else {
            wireframe?.showErrorModalAlert(view, content: "\(Constants.notFoundCredentials)\(email)", customActions: [action], completion: nil)
            return Constants.notLogged
        }
        wireframe?.showCustomModalAlert(view, title: AlertType.information.title, content: Constants.userLogged, customActions: [action], completion: nil)
        return "\(Constants.loggedAs)\(emailRetrieve)"
    }
}


// MARK: - RegisterInteractorOutputContract

extension RegisterPresenter: RegisterInteractorOutputContract {}


// MARK: - RegisterWireframeOutputContract

extension RegisterPresenter: RegisterWireframeOutputContract {}
