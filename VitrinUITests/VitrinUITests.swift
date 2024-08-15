//
//  VitrinUITests.swift
//  VitrinUITests
//
//  Created by Sema Topcu on 8/15/24.
//

import XCTest

final class VitrinUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
}

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        let sidebarCollectionView = app.collectionViews["Sidebar"]
        
        let firstProductButton = sidebarCollectionView/*@START_MENU_TOKEN@*/.buttons["Mens Casual Premium Slim, $22.30"]/*[[".cells.buttons[\"Mens Casual Premium Slim, $22.30\"]",".buttons[\"Mens Casual Premium Slim, $22.30\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(firstProductButton.exists, "First product button should exist")
            firstProductButton.swipeUp()
        
        let secondProductButton = sidebarCollectionView.buttons["Mens Casual Slim Fit, $15.99"]
        XCTAssertTrue(secondProductButton.exists, "Second product button should exist")
            secondProductButton.swipeRight()
        
}

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
