//
//  test_appUITests.swift
//  test-appUITests
//
//  Created by Miguel Salinas on 5/3/24.
//

import XCTest
import qaml

final class test_appUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testSearching() async throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
        app.launch()
        
        let q = QamlClient(apiKey: ProcessInfo.processInfo.environment["QAML_API_KEY"]!, app: app)
        
        try await q.execute("type google.com into the search bar at the bottom")
        try await q.execute("tap go")
        try await Task.sleep(nanoseconds: 1 * NSEC_PER_SEC)
        try await q.execute("scroll down")
        try await q.assertCondition("The screen shows google's site")
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
