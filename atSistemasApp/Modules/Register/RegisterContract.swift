//
//  RegisterContract.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import UIKit

protocol RegisterEntityContract {
    
}

protocol RegisterInteractorContract  {
    var output: RegisterInteractorOutputContract? {get set}
    
    func saveLastUserView()
}

protocol RegisterInteractorOutputContract: class {
    
}

protocol RegisterPresenterContract {
    var view: RegisterViewContract! { get set }
    var interactor: RegisterInteractorContract! { get set }
    var entity: RegisterEntityContract? { get set }
    var wireframe: RegisterWireframeContract? { get set }

    func viewDidLoad()
    func viewWillAppear()
    func badDataIntput(message: String)
}

protocol RegisterViewContract: BaseViewController {
    var presenter: RegisterPresenterContract! { get set }
    
}

protocol RegisterWireframeContract: BaseWireframe {
    var output: RegisterWireframeOutputContract? { get set }
    var view: UIViewController! { get set }
}

protocol RegisterWireframeOutputContract: class {

}
