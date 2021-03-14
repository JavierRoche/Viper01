//
//  PermissionsView.swift
//  atSistemasApp
//
//  Created by APPLE on 10/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//
//

import UIKit

class PermissionsView: BaseViewController, PermissionsViewContract {
	var presenter: PermissionsPresenterContract!

    
	// MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.presenter.viewWillAppear()
    }
}
