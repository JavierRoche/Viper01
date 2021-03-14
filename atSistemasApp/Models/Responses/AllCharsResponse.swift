//
//  AllCharsResponse.swift
//  atSistemasApp
//
//  Created by APPLE on 12/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import Foundation

struct AllCharsResponse: Codable {
    let code: Int?
    let status: String?
    let copyright: String?
    let data: DataList
}

struct DataList: Codable {
    let total: Int?
    let results: [Character]
}

struct Character: Codable, Hashable {
    let id: Int?
    let name: String?
    let thumbnail: Thumbnail
    var favourite: Bool?
}

struct Thumbnail: Codable, Hashable {
    var path: String?
    let imageExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}
