//
//  MarvelListBuilder.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import Foundation

class MarvelListBuilder {
    static func build() -> MarvelListView {
        let view = MarvelListView.init(nibName: String(describing: MarvelListView.self), bundle: nil)
        let presenter = MarvelListPresenter()
        let entity = MarvelListEntity()
        let wireframe = MarvelListWireframe()
        
        let userDefaultsProvider = UserDefaultsProvider()
        let remoteDataProvider = RemoteDataProvider()
        let interactor = MarvelListInteractor(userDefaultsProvider: userDefaultsProvider,
                                              remoteDataProvider: remoteDataProvider)
        
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
