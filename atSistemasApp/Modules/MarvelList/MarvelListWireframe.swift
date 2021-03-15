//
//  MarvelListWireframe.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import UIKit

class MarvelListWireframe: BaseWireframe, MarvelListWireframeContract {
    weak var output: MarvelListWireframeOutputContract?
    weak var view: UIViewController?
    
    func showCharDetailView(char: Character) {
        let detailModule = MarvelDetailBuilder.build(char: char)
        self.presentView(from: self.view, useCase: detailModule, withTransition: .modal, completion: nil)
    }
}
