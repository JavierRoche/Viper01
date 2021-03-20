//
//  MarvelListPresenter.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import Foundation
import PromiseKit

class MarvelListPresenter: MarvelListPresenterContract {
    weak var view: MarvelListViewContract!
    var interactor: MarvelListInteractorContract!
    var entity: MarvelListEntityContract?
    var wireframe: MarvelListWireframeContract?
    
    
    // MARK: Public Functions
    
    func viewDidLoad() {}

    func viewWillAppear() {
        interactor.saveLastUserView()
        
        firstly {
            interactor.getMarvelList()
            
        }.done { [weak self] marvelList in
            self?.view.charListDidChange(charList: marvelList)
            
        }.catch { [weak self] error in
            guard let promiseError = error as? NetworkError else { return }
            let action = UIAlertAction(title: Constants.accept, style: .default, handler: nil)
            self?.wireframe?.showErrorModalAlert(self?.view, content: promiseError.localizedDescription, customActions: [action], completion: nil)
            self?.view.charListDidChange(charList: [])
        }
    }
    
    func saveFavouriteChar(name: String) {
        interactor.saveFavouriteChar(name: name)
    }
    
    func isFavouriteChar(name: String) -> Bool {
        return interactor.isFavouriteChar(name: name)
    }
    
    func deleteFavouriteChar(name: String) {
        interactor.deleteFavouriteChar(name: name)
    }
    
    func charCellTapped(char: Character) {
        wireframe?.showCharDetailView(char: char)
    }
}


// MARK: - MarvelListInteractorOutputContract

extension MarvelListPresenter: MarvelListInteractorOutputContract {}


// MARK: - MarvelListWireframeOutputContract

extension MarvelListPresenter: MarvelListWireframeOutputContract {}
