//
//  TidalUITests.swift
//  TidalUITests
//
//  Created by Jawad on 30/11/2019.
//  Copyright © 2019 Jawad. All rights reserved.
//

import XCTest

class TidalUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        let app = XCUIApplication()
               app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

  

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testTapSearchPerformance() {
        self.measure {
            XCUIApplication().launch()
            XCUIApplication().searchFields["Search Artist"].tap()
        }
    }
    
    func testSearchBarExists() {
        XCUIApplication().launch()
        XCTAssertTrue( XCUIApplication().searchFields["Search Artist"].exists)
    }
    
   
    func testArtistTableAndRowsExists() {
                                        
        
        let app = XCUIApplication()
        app.searchFields["Search Artist"].tap()
        app.searchFields["Search Artist"].typeText("Prince")
        let table = app.tables.element
        let loaded = NSPredicate(format: "count > 0")
        expectation(for: loaded, evaluatedWith: table.cells, handler: nil)
        
        XCTAssertTrue(table.exists)
        waitForExpectations(timeout: 5, handler: nil)
  
    }
    
    func testAlbumScreenExists(){
       let app = XCUIApplication()
       app.searchFields["Search Artist"].tap()
       app.searchFields["Search Artist"].typeText("Prince")
       app.tables.cells.containing(.staticText, identifier:"Prince").staticTexts["50 albums"].tap()
        let loaded = NSPredicate(format: "count > 0")
        let collectionView = app.collectionViews.element
        expectation(for: loaded, evaluatedWith: collectionView.cells, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
