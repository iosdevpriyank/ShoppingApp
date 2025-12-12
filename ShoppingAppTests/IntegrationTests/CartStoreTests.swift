//
//  CartStoreTests.swift
//  ShoppingAppTests
//
//  Created by Akshat Gandhi on 12/12/25.
//

import XCTest
@testable import ShoppingApp

final class CartStoreTests: XCTestCase {
    
    var store: CartStore!
    
    override func setUp() async throws {
        try await super.setUp()
        store = await CartStore()
    }
    
    override func tearDown() async throws {
        await store.clear()
        store = nil
        try await super.tearDown()
    }
    
    func test_add_addsNewItem() async {
        let item = await CartItem(product: Product.mock1, quantity: 1)
        
        await store.add(item)
        let items = await store.items()
        
        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(items.first?.product.id, Product.mock1.id)
    }
    
    func test_add_increasesQuantity_whenProductExists() async {
        let item1 = await CartItem(product: Product.mock1, quantity: 1)
        let item2 = await CartItem(product: Product.mock1, quantity: 2)
        
        await store.add(item1)
        await store.add(item2)
        let items = await store.items()
        
        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(items.first?.quantity, 3)
    }
    
    func test_remove_removesItem() async {
        let item = await CartItem(product: Product.mock1, quantity: 1)
        await store.add(item)
        
        await store.remove(at: 0)
        let items = await store.items()
        
        XCTAssertEqual(items.count, 0)
    }
    
    func test_clear_removesAllItems() async {
        await store.add(CartItem(product: Product.mock1, quantity: 1))
        await store.add(CartItem(product: Product.mock2, quantity: 1))
        
        await store.clear()
        let items = await store.items()
        
        XCTAssertEqual(items.count, 0)
    }
    
    func test_itemCount_returnsCorrectTotal() async {
        await store.add(CartItem(product: Product.mock1, quantity: 2))
        await store.add(CartItem(product: Product.mock2, quantity: 3))
        
        let count = await store.itemCount()
        
        XCTAssertEqual(count, 5)
    }
    
}
