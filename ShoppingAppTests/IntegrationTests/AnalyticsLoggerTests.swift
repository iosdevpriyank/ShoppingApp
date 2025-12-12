//
//  AnalyticsLoggerTests.swift
//  ShoppingAppTests
//
//  Created by Akshat Gandhi on 12/12/25.
//

import XCTest
@testable import ShoppingApp

final class AnalyticsLoggerTests: XCTestCase {
    
    var logger: AnalyticsLogger!
    
    override func setUp() async throws {
        try await super.setUp()
        logger = AnalyticsLogger()
    }
    
    override func tearDown() async throws {
        logger = nil
        try await super.tearDown()
    }
    
    
}
