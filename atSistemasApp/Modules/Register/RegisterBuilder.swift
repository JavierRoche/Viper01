//
//  RegisterBuilder.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import Foundation

class RegisterBuilder {
    static func build() -> RegisterView {
        let view = RegisterView.init(nibName: String(describing: RegisterView.self), bundle: nil)
        let presenter = RegisterPresenter()
        let entity = RegisterEntity()
        let wireframe = RegisterWireframe()
        
        let userDefaultsProvider = UserDefaultsProvider()
        let interactor = RegisterInteractor(provider: userDefaultsProvider)
        
        view.presenter = presenter
        view.presenter.view = view
        view.presenter.entity = entity
        view.presenter.interactor = interactor
        view.presenter.interactor.output = presenter
        view.presenter.wireframe = wireframe
        
        view.presenter.wireframe?.output = presenter
        //view.presenter.wireframe.view = view
        
        return view
    }
}
