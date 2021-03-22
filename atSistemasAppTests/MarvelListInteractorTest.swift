//
//  MarvelListInteractorTest.swift
//  atSistemasAppTests
//
//  Created by APPLE on 22/03/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import XCTest
@testable import PromiseKit
@testable import atSistemasApp

class MarvelListInteractorTest: XCTestCase {
    
    var mockCharsDataManager: MarvelListInteractorMock!
    var marvelListInteractor: MarvelListInteractor!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWithNoDataRetrieveEmptyMarvelList() {
        firstly {
            mockCharsDataManager.getMarvelList()
        }.done { response in
            XCTAssertTrue(response.isEmpty)
        }.catch { _ in }
    }
}

