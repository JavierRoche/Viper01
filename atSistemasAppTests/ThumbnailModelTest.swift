//
//  ThumbnailModelTest.swift
//  atSistemasAppTests
//
//  Created by APPLE on 22/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import XCTest
@testable import atSistemasApp

class ThumbnailModelTest: XCTestCase {
    
    let thumbnail1 = Thumbnail(path: "http://111111", imageExtension: ".jpg")
    let thumbnail2 = Thumbnail(path: "http://222222", imageExtension: ".jpg")

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreation() {
        XCTAssertNotNil(thumbnail1)
        XCTAssertNotNil(thumbnail2)
    }

    func testEquality(){
        XCTAssertNotEqual(thumbnail1, thumbnail2)
        XCTAssertEqual(thumbnail1, Thumbnail(path: "http://111111", imageExtension: ".jpg"))
    }

    func testHashes(){
        XCTAssertEqual(thumbnail1.hashValue,
                       Thumbnail(path: "http://111111", imageExtension: ".jpg").hashValue)
        XCTAssertEqual(thumbnail2.hashValue,
                       Thumbnail(path: "http://222222", imageExtension: ".jpg").hashValue)
        
        XCTAssertNotEqual(thumbnail1.hashValue, thumbnail2.hashValue)

    }

    func testRepresentation(){
        XCTAssertEqual(thumbnail1.debugDescription, "<Thumbnail: http://111111.jpg>")
    }
}


