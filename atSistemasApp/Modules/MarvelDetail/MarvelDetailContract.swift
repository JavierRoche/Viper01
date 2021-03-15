//
//  MarvelDetailContract.swift
//  atSistemasApp
//
//  Created by APPLE on 14/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import UIKit
import PromiseKit

protocol MarvelDetailEntityContract {
    
}

protocol MarvelDetailInteractorContract {
    var output: MarvelDetailInteractorOutputContract? {get set}
    
    func getChar() -> Character
    func getComicList() -> Promise<[Comic]>
}

protocol MarvelDetailInteractorOutputContract: class {
    
}

protocol MarvelDetailPresenterContract {
    var view: MarvelDetailViewContract! { get set }
    var interactor: MarvelDetailInteractorContract! { get set }
    var entity: MarvelDetailEntityContract? { get set }
    var wireframe: MarvelDetailWireframeContract? { get set }

    func viewDidLoad() -> Character
    func viewWillAppear()
}

protocol MarvelDetailViewContract: BaseViewController {
    var presenter: MarvelDetailPresenterContract! { get set }
    
    func comicListDidChange(comicList: [Comic])
}

protocol MarvelDetailWireframeContract: BaseWireframe {
    var output: MarvelDetailWireframeOutputContract? { get set }
    var view: UIViewController? { get set }
}

protocol MarvelDetailWireframeOutputContract: class {

}
