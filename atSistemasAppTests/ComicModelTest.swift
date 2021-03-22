//
//  ComicModelTest.swift
//  atSistemasAppTests
//
//  Created by APPLE on 22/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import XCTest
@testable import atSistemasApp

class ComicModelTest: XCTestCase {
    
    let comic1 = Comic(id: 111111, title: "comic1", thumbnail: Thumbnail(path: String(), imageExtension: String()))
    let comic2 = Comic(id: 222222, title: "comic2", thumbnail: Thumbnail(path: String(), imageExtension: String()))

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreation() {
        XCTAssertNotNil(comic1)
        XCTAssertNotNil(comic2)
    }

    func testEquality(){
        XCTAssertNotEqual(comic1, comic2)
        XCTAssertEqual(comic1, Comic(id: 111111, title: "comic1", thumbnail: Thumbnail(path: String(), imageExtension: String())))
    }

    func testHashes(){
        XCTAssertEqual(comic1.hashValue,
                       Comic(id: 111111, title: "comic1", thumbnail: Thumbnail(path: String(), imageExtension: String()))
                        .hashValue)
        XCTAssertEqual(comic2.hashValue,
                       Comic(id: 222222, title: "comic2", thumbnail: Thumbnail(path: String(), imageExtension: String()))
                        .hashValue)
        
        XCTAssertNotEqual(comic1.hashValue, comic2.hashValue)

    }

    func testRepresentation(){
        XCTAssertEqual(comic1.debugDescription, "<Comic: 111111/comic1>")
    }
}


