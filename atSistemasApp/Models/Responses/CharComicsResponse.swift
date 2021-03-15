//
//  CharComicsResponse.swift
//  atSistemasApp
//
//  Created by APPLE on 14/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

struct CharComicsResponse: Codable {
    let code: Int?
    let status: String?
    let copyright: String?
    let data: CoverList
}

struct CoverList: Codable {
    let results: [Comic]
}

struct Comic: Codable, Hashable {
    let id: Int?
    let name: String?
    let thumbnail: Thumbnail
}
