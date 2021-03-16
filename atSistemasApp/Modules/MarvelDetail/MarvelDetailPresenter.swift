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
            guard let promiseError = error as? NetworkError else { return }
            let action = UIAlertAction(title: Constants.accept, style: .default, handler: nil)
            self?.wireframe?.showErrorModalAlert(self?.view, content: promiseError.localizedDescription, customActions: [action], completion: nil)
            self?.view.comicListDidChange(comicList: [])
        }
    }
}


// MARK: - MarvelDetailInteractorOutputContract

extension MarvelDetailPresenter: MarvelDetailInteractorOutputContract {
    
}


// MARK: - MarvelDetailWireframeOutputContract

extension MarvelDetailPresenter: MarvelDetailWireframeOutputContract {
    
}
