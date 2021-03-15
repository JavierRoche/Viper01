//
//  MarvelDetailPresenter.swift
//  atSistemasApp
//
//  Created by APPLE on 14/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import Foundation
import PromiseKit

class MarvelDetailPresenter: MarvelDetailPresenterContract {
    weak var view: MarvelDetailViewContract!
    var interactor: MarvelDetailInteractorContract!
    var entity: MarvelDetailEntityContract?
    var wireframe: MarvelDetailWireframeContract?

    
    // MARK: Public Functions
    
    func viewDidLoad() -> Character {
        return interactor.getChar()
    }

    func viewWillAppear() {
        firstly {
            interactor.getComicList()
            
        }.done { [weak self] comicList in
            self?.view.comicListDidChange(comicList: comicList)
            
        }.catch { [weak self] error in
            self?.wireframe?.showErrorModalAlert(nil, content: error.localizedDescription, completion: nil)
        }
    }
}


// MARK: - MarvelDetailInteractorOutputContract

extension MarvelDetailPresenter: MarvelDetailInteractorOutputContract {
    
}


// MARK: - MarvelDetailWireframeOutputContract

extension MarvelDetailPresenter: MarvelDetailWireframeOutputContract {
    
}
