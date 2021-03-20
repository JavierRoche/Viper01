//
//  KeyChainProviderContract.swift
//  atSistemasApp
//
//  Created by APPLE on 20/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

protocol KeyChainProviderContract {
    func save(email: String, password: String) -> String?
    func load(email: String, password: String) -> String?
}
