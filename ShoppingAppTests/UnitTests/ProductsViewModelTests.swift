//
//  ProductsViewModelTests.swift
//  ShoppingAppTests
//
//  Created by Akshat Gandhi on 12/12/25.
//

import XCTest
@testable import ShoppingApp

@MainActor
final class ProductsViewModelTests: XCTestCase {
    
    var viewModel: ProductsViewModel!
    var mockAPI: MockProductAPI!
    var mockAnalytics: MockAnalytics!
    
    override func setUp() {
        super.setUp()
        mockAPI = MockProductAPI()
        mockAnalytics = MockAnalytics()
        viewModel = .init(productAPI: mockAPI, analytics: mockAnalytics)
    }
    
    override func tearDown() {
        viewModel = nil
        mockAPI = nil
        mockAnalytics = nil
        super.tearDown()
    }
    
    func test_loadProducts_populatesProducts() async {
        mockAPI.productsToReturn = [
            Product.mock1,
            Product.mock2]
        
        await viewModel.loadProducts()
        
        XCTAssertTrue(mockAPI.fetchProductsCalled)
        XCTAssertEqual(viewModel.products.count, 2)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func test_loadProducts_setsLoadingState() async {
        mockAPI.productsToReturn = []
        
        XCTAssertFalse(viewModel.isLoading)
        
        await viewModel.loadProducts()
        
        try? await Task.sleep(nanoseconds: 10_000_000)
        
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func test_loadProducts_handlesError() async {
        mockAPI.shouldThrowError = true
        
        await viewModel.loadProducts()
        
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.products.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func test_loadProducts_logsAnalytics() async {
        mockAPI.productsToReturn = []
        
        await viewModel.loadProducts()
        
        XCTAssertTrue(mockAnalytics.screenViewsLogged.contains("products"))
    }
    
    func test_searchProducts_filtersResults() async {
        mockAPI.productsToReturn = [
            Product.mock1, // Wireless Headphones
            Product.mock2, // Smart Watch
            Product.mock3  // Coffee Maker
        ]
        viewModel.searchQuery = "watch"
        
        await viewModel.searchProducts()
        
        XCTAssertTrue(mockAPI.searchProductsCalled)
        XCTAssertEqual(viewModel.products.count, 1)
        XCTAssertEqual(viewModel.products.first?.name, "Smart Watch")
    }
    
    func test_searchProducts_logsAnalytics() async {
        // Arrange
        mockAPI.productsToReturn = []
        viewModel.searchQuery = "headphones"
        
        // Act
        await viewModel.searchProducts()
        
        // Assert
        let searchEvents = mockAnalytics.eventsLogged.filter { $0.name == "search" }
        XCTAssertEqual(searchEvents.count, 1)
        XCTAssertEqual(searchEvents.first?.parameters["query"] as? String, "headphones")
    }
    
    func test_searchProducts_loadsAllProducts_whenQueryIsEmpty() async {
        mockAPI.productsToReturn = [Product.mock1, Product.mock2]
        viewModel.searchQuery = ""
        
        await viewModel.searchProducts()
        
        // Assert
        XCTAssertTrue(mockAPI.fetchProductsCalled)
        XCTAssertEqual(viewModel.products.count, 2)
    }
}
