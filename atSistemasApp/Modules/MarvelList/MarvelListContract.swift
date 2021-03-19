//
//  MarvelListContract.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import Foundation
import PromiseKit

protocol MarvelListEntityContract {
    
}

protocol MarvelListInteractorContract {
    var output: MarvelListInteractorOutputContract? {get set}
    
    func saveLastUserView()
    func getMarvelList() -> Promise<[Character]>
    func saveFavouriteChar(name: String)
    func isFavouriteChar(name: String) -> Bool
    func deleteFavouriteChar(name: String)
}

protocol MarvelListInteractorOutputContract: class {
    
}

protocol MarvelListPresenterContract {
    var view: MarvelListViewContract! { get set }
    var interactor: MarvelListInteractorContract! { get set }
    var entity: MarvelListEntityContract? { get set }
    var wireframe: MarvelListWireframeContract? { get set }

    func viewDidLoad()
    func viewWillAppear()
    func saveFavouriteChar(name: String)
    func isFavouriteChar(name: String) -> Bool
    func deleteFavouriteChar(name: String)
    func charCellTapped(char: Character)
}

protocol MarvelListViewContract: BaseViewController {
    var presenter: MarvelListPresenterContract! { get set }
    
    func charListDidChange(charList: [Character])
}

protocol MarvelListWireframeContract: BaseWireframe {
    var output: MarvelListWireframeOutputContract? { get set }
    var view: UIViewController? { get set }
    
    func showCharDetailView(char: Character)
}

protocol MarvelListWireframeOutputContract: class {

}
