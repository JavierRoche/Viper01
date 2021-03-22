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
    let description: String?
    let thumbnail: Thumbnail
    let urls: [UrlList]
    var favourite: Bool?
}

struct Thumbnail: Codable, Hashable {
    var path: String?
    var imageExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
    
    init(thumbnailDAO: ThumbnailDAO) {
        path = thumbnailDAO.path
        imageExtension = thumbnailDAO.imageExtension
    }
    
    init(path: String, imageExtension: String) {
        self.path = path
        self.imageExtension = imageExtension
    }
}

struct UrlList: Codable, Hashable {
    let type: String
    let url: String
}


// MARK: Character Extension

extension Character: Equatable {
    /// Only used for testing
    init(id: Int?, name: String?, description: String?, thumbnail: Thumbnail?, urls: [UrlList]?, favourite: Bool?) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail!
        self.urls = []
        self.favourite = favourite
    }
    
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Character: CustomDebugStringConvertible {
    var debugDescription: String {
        return "<\(type(of: self)): \(self.id ?? Int())/\(self.name ?? String())>"
    }
}


// MARK: Thumbnail Extension

extension Thumbnail: Equatable {
    static func == (lhs: Thumbnail, rhs: Thumbnail) -> Bool {
        return lhs.path == rhs.path && lhs.imageExtension == rhs.imageExtension
    }
}

extension Thumbnail: CustomDebugStringConvertible {
    var debugDescription: String {
        return "<\(type(of: self)): \(self.path ?? String())\(self.imageExtension ?? String())>"
    }
}
