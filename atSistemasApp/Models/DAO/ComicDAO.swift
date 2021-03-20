//
//  ComicDAO.swift
//  atSistemasApp
//
//  Created by APPLE on 17/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation
import ObjectMapper

struct ComicDAO: ImmutableMappable {
    let id: Int
    let title: String
    let thumbnail: ThumbnailDAO

    init(map: Map) throws {
        id = try map.value("id")
        title = try map.value("title")
        thumbnail = try map.value("thumbnail")
    }

    func mapping(map: Map) {
        id >>> map["id"]
        title >>> map["title"]
        thumbnail >>> map["thumbnail"]
    }
}
