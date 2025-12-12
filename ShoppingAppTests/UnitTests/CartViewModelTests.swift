//
//  CartViewModelTests.swift
//  ShoppingAppTests
//
//  Created by Akshat Gandhi on 12/12/25.
//

import XCTest
@testable import ShoppingApp

@MainActor
final class CartViewModelTests: XCTestCase {
    var viewModel: CartViewModel!
    var mockStore: MockCartStore!
    var discountEngine = DiscountEngine()
    var mockAnalytics: MockAnalytics!
    
    override func setUp() {
        super.setUp()
        mockStore = MockCartStore()
        mockAnalytics = MockAnalytics()
        viewModel = CartViewModel(cart: mockStore, discount: discountEngine,  analytics: mockAnalytics, )
    }
    
    override func tearDown() {
        viewModel = nil
        mockStore = nil
        mockAnalytics = nil
        super.tearDown()
    }
    
    func test_loadCart_populateItems() async {
        mockStore.itemsToReturn = [
            CartItem(product: Product.mock1, quantity: 1),
            CartItem(product: Product.mock2, quantity: 2)
        ]
        
        await viewModel.loadCart()
        
        XCTAssertEqual(viewModel.items.count, 2)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func test_loadCart_calculateSubtotal() async {
        mockStore.itemsToReturn = [
            CartItem(product: Product.mock1, quantity: 1),
            CartItem(product: Product.mock2, quantity: 1)
        ]
        
        await viewModel.loadCart()
        
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        XCTAssertEqual(viewModel.subtotal, 699.98, accuracy: 0.1)
    }
    
    func test_loadCart_appliesDiscount_whenSubtotalOver200() async {
        mockStore.itemsToReturn = [
            CartItem(product: Product.mock1, quantity: 1)
        ]
        
        await viewModel.loadCart()
        
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        XCTAssertGreaterThan(viewModel.discountAmount, 0)
        XCTAssertLessThan(viewModel.totalPrice, viewModel.subtotal)
    }
    
    func test_loadCart_logsAnalytics() async {
        mockStore.itemsToReturn = []
        
        await viewModel.loadCart()
        
        XCTAssertTrue(mockAnalytics.screenViewsLogged.contains("cart"))
    }
    
    func test_addProduct_addsItemsToCart() async {
        let product = Product.mock1
        mockStore.itemsToReturn = []
        
        await viewModel.addProduct(product)
        
        let addToCartEvents = mockAnalytics.eventsLogged.filter {$0.name == "add_to_cart"}
        XCTAssertEqual(addToCartEvents.count, 1)
        
        let parameters = addToCartEvents.first?.parameters
        XCTAssertEqual(parameters?["product_id"] as? String, product.id)
    }
    
    func test_removeItem_removesItemFromCart() async {
        mockStore.itemsToReturn = [
            CartItem(product: Product.mock1, quantity: 1),
            CartItem(product: Product.mock2, quantity: 1)
        ]
        await viewModel.loadCart()
        
        await viewModel.removeItem(at: 0)
        
        XCTAssertTrue(mockStore.removeCalled)
        XCTAssertEqual(viewModel.items.count, 1)
    }
    
    func test_removeItem_recalculatesTotal() async {
        mockStore.itemsToReturn = [
            CartItem(product: Product.mock1, quantity: 1)
        ]
        await viewModel.loadCart()
        try? await Task.sleep(nanoseconds: 100_000_000)
        let initialTotal = viewModel.totalPrice
        
        await viewModel.removeItem(at: 0)
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        XCTAssertLessThan(viewModel.totalPrice, initialTotal)
        XCTAssertEqual(viewModel.totalPrice, 0)
    }
    
    func test_removeItem_logsAnalytics() async {
        mockStore.itemsToReturn = [
            CartItem(product: Product.mock1, quantity: 1)
        ]
        await viewModel.loadCart()
        
        await viewModel.removeItem(at: 0)
        
        let removeEvents = mockAnalytics.eventsLogged.filter { $0.name == "remove_from_cart" }
        XCTAssertEqual(removeEvents.count, 1)
    }
    
    func test_clearCart_removesAllItems() async {
        mockStore.itemsToReturn = [
            CartItem(product: Product.mock1, quantity: 1),
            CartItem(product: Product.mock2, quantity: 1)
        ]
        await viewModel.loadCart()
        
        await viewModel.clearCart()
        
        XCTAssertTrue(mockStore.clearCalled)
        XCTAssertEqual(viewModel.items.count, 0)
        
        try? await Task.sleep(nanoseconds: 100_000_000)
        XCTAssertEqual(viewModel.totalPrice, 0)
    }
    
    func test_discountPercentage_reflects_currentSubtotal() async {
        mockStore.itemsToReturn = [
            CartItem(product: Product(id: "1", name: "Item", description: "", price: 50, imageURL: nil, category: ""), quantity: 1)
        ]
        await viewModel.loadCart()
        try? await Task.sleep(nanoseconds: 100_000_000)
        XCTAssertEqual(viewModel.discountPercentage, 0)
        
        mockStore.itemsToReturn = [
            CartItem(product: Product(id: "1", name: "Item", description: "", price: 150, imageURL: nil, category: ""), quantity: 1)
        ]
        await viewModel.loadCart()
        try? await Task.sleep(nanoseconds: 100_000_000)
        XCTAssertEqual(viewModel.discountPercentage, 10)
        
        mockStore.itemsToReturn = [
            CartItem(product: Product(id: "1", name: "Item", description: "", price: 250, imageURL: nil, category: ""), quantity: 1)
        ]
        await viewModel.loadCart()
        try? await Task.sleep(nanoseconds: 100_000_000)
        XCTAssertEqual(viewModel.discountPercentage, 15)
    }
}
