//
//  FacultativaUniWalletUITests.swift
//  FacultativaUniWalletUITests
//
//  Created by Anibal Rodriguez on 23/5/24.
//

import XCTest

final class FacultativaUniWalletUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLogIn() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let sugDynamicsSgCard = app.buttons["loginButton"]
          XCTAssertTrue(sugDynamicsSgCard.exists)
          sugDynamicsSgCard.tap()
        
        let emailText = app.textFields["email"]
                XCTAssertTrue(emailText.waitForExistence(timeout: 1))
                emailText.tap()
                emailText.typeText("anibalrodriguezdeveloper@gmail.com")
        
        let passwordText = app.secureTextFields["password"]
                XCTAssertTrue(passwordText.waitForExistence(timeout: 1))
                passwordText.tap()
                passwordText.typeText("Password123*")
        
        let signInButton = app.buttons["signIn"]
          XCTAssertTrue(signInButton.exists)
          signInButton.tap()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
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
