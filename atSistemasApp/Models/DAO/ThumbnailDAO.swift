//
//  ThumbnailDAO.swift
//  atSistemasApp
//
//  Created by APPLE on 17/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation
import ObjectMapper

struct ThumbnailDAO: ImmutableMappable {
    let path: String
    let imageExtension: String

    init(map: Map) throws {
        path = try map.value("path")
        imageExtension = try map.value("extension")
    }

    func mapping(map: Map) {
        path >>> map["path"]
        imageExtension >>> map["extension"]
    }
}
