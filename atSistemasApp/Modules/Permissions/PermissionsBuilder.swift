//
//  PermissionsBuilder.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import Foundation

class PermissionsBuilder {
    static func build() -> PermissionsView {
        let view = PermissionsView()
        //let view = PermissionsView(nibName: String(describing: PermissionsView.self), bundle: nil)
        let presenter = PermissionsPresenter()
        let entity = PermissionsEntity()
        let wireframe = PermissionsWireframe()
        
        let userDefaultsProvider = UserDefaultsProvider()
        let coreDataProvider = CoreDataProvider()
        let interactor = PermissionsInteractor(userDefaultsProvider: userDefaultsProvider, coreDataProvider: coreDataProvider)
        
        view.presenter = presenter
        view.presenter.view = view
        view.presenter.entity = entity
        view.presenter.interactor = interactor
        view.presenter.interactor.output = presenter
        view.presenter.wireframe = wireframe
        
        view.presenter.wireframe?.output = presenter
        view.presenter.wireframe?.view = view
        
        return view
    }
}
