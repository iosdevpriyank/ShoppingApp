//
//  DiscountEngineTests.swift
//  ShoppingAppTests
//
//  Created by Akshat Gandhi on 12/12/25.
//

import XCTest
@testable import ShoppingApp

final class DiscountEngineTests: XCTestCase {
    
    var discountEngine: DiscountEngine!
    
    override func setUp() {
        super.setUp()
        discountEngine = DiscountEngine()
    }
    
    override func tearDown() {
        discountEngine = nil
        super.tearDown()
    }
    
    func test_calculate_noDiscount_whenSubTotalBelow100() {
        let subtotal: Double = 50.0
        
        let result = discountEngine.calculate(subtotal: subtotal)
        
        XCTAssertEqual(result, 50.0, accuracy: 0.01)
    }
    
    func test_calculate_10PercentDiscount_whenSubtotalBetween100And200() {
        let subtotal: Double = 150.0
        
        let result = discountEngine.calculate(subtotal: subtotal)
        
        XCTAssertEqual(result, 135.0, accuracy: 0.01)
    }
    
    func test_calculate_15PercentDiscount_whenSubtotal200OrMore() {
        let subtotal: Double = 200.0
        
        let result = discountEngine.calculate(subtotal: subtotal)
        
        XCTAssertEqual(result, 170.0, accuracy: 0.01)
    }
    
    func test_discountPercentage_returns0_whenSubtotalBelow100() {
        let subtotal: Double = 99.99
        
        let result = discountEngine.discountPercentage(for: subtotal)
        
        XCTAssertEqual(result, 0)
    }
    
    func test_discountPercentage_returns10_whenSubtotalBetween100And200() {
        let subtotal: Double = 150.0
        
        let result = discountEngine.discountPercentage(for: subtotal)
        
        XCTAssertEqual(result, 10)
    }
    
    func test_discountPercentage_returns15_whenSubtotal200OrMore() {
        let subtotal: Double = 250.0
        
        let result = discountEngine.discountPercentage(for: subtotal)
        
        XCTAssertEqual(result, 15)
    }
    
    
}
