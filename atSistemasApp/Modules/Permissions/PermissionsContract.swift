//
//  PermissionsContract.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import Foundation

protocol PermissionsEntityContract {
    
}

protocol PermissionsInteractorContract: BaseInteractor {
    var output: PermissionsInteractorOutputContract? {get set}
}

protocol PermissionsInteractorOutputContract: class {
    
}

protocol PermissionsPresenterContract {
    var view: PermissionsViewContract! { get set }
    var interactor: PermissionsInteractorContract! { get set }
    var entity: PermissionsEntityContract? { get set }
    var wireframe: PermissionsWireframeContract? { get set }

    func viewDidLoad()
    func viewWillAppear()
}

protocol PermissionsViewContract: BaseViewController {
    var presenter: PermissionsPresenterContract! { get set }
}

protocol PermissionsWireframeContract: BaseWireframe {
    var output: PermissionsWireframeOutputContract? { get set }
    //var view: UIViewController! { get set }
}

protocol PermissionsWireframeOutputContract: class {

}
