//
//  UIStringAdditions.swift
//  atSistemasApp
//
//  Created by APPLE on 12/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit

enum Constants {
    static let invalidUrl: String = "URL invalid"
    static let componentsError: String = "Not able to create components"
    static let finalURLError: String = "Unable to retrieve final URL"
    static let contentTypeValue: [String] = ["application/json"]
    static let contentType: String = "Content-Type"
    static let refreshMessage: String = "Pull to refresh"
    static let preconditionFailure: String = "This method needs to be overriden by concrete subclass."
    static let urlImageSize: String = "standard_large"
    static let listDashIS: String = "list.dash"
    static let lockFillIS: String = "list.dash"
    static let rosetteIS: String = "rosette"
    static let iconImageWarning: String = "exclamationmark.triangle"
    static let appTitle: String = "Marvel Characters"
    static let error: String = "Error"
    static let accept: String = "Accept"
    static let NSCoderError: String = "init(coder:) has not been implemented"
    static let https: String = "https"
    static let apiURL: String = "https://gateway.marvel.com"
    static let path: String = "/v1/public/characters"
    static let ts: String = "ts"
    static let tsValue: String = "tushe"
    static let apikey: String = "apikey"
    static let apikeyValue: String = "254e6cdbf08e4e698f90ab85860d963a"
    static let hash: String = "hash"
    static let hashValue: String = "51fa5500ec6da8064d901fdef50dfc4b"
    static let coreDataStorage: String = "DataModel"
    static let entityFavouriteChars: String = "FavouriteChars"
    static let entityFavouriteCharsId: String = "id"
    static let heart: String = "heart"
    static let heartFill: String = "heart.fill"
    static let marvel: String = "Marvel"
    static let register: String = "Register"
    static let permissions: String = "Permissions"
    static let keyUserView: String = "keyUserView"
    static let keyFirstExecution: String = "keyFirstExecution"
    static let keyData: String = "data"
    static let keyResults: String = "results"
    static let apiBadResponse: String = "network_error_parsing_description"
    static let apiBadData: String = "network_error_bad_data"
    
    /// Permissions Tab
    static let todo: String = "TODO"
    static let done: String = "DONE"
    static let entityPermission: String = "Permission"
    static let entityPermissionState: String = "state"
    static let entityPermissionTitle: String = "title"
    static let keyFavourite: String = "keyFavourite"
    static let camera: String = "Camera"
    static let location: String = "Geolocation"
    static let photosLibrary: String = "Photos Library"
    static let authorized: String = "Authorized"
    static let notAuthorized: String = "Not authorized"
}
