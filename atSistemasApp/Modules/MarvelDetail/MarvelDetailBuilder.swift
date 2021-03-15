//
//  MarvelDetailBuilder.swift
//  atSistemasApp
//
//  Created by APPLE on 14/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import Foundation

class MarvelDetailBuilder {
    static func build(char: Character) -> MarvelDetailView {
        let view = MarvelDetailView.init(nibName: String(describing: MarvelDetailView.self), bundle: nil)
        let presenter = MarvelDetailPresenter()
        let entity = MarvelDetailEntity()
        let wireframe = MarvelDetailWireframe()
        
        let remoteDataProvider = RemoteDataProvider()
        let interactor = MarvelDetailInteractor(provider: remoteDataProvider, char: char)
        
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
