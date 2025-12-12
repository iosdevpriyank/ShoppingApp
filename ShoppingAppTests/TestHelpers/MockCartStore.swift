//
//  MockCartStore.swift
//  ShoppingAppTests
//
//  Created by Akshat Gandhi on 12/12/25.
//

import Foundation
@testable import ShoppingApp

final class MockCartStore: CartReadable, CartWritable, @unchecked Sendable {
    var itemsToReturn: [CartItem] = []
    var addCalled = false
    var removeCalled = false
    var clearCalled = false
    
    func items() async -> [CartItem] {
        itemsToReturn
    }
    
    func itemCount() async -> Int {
        itemsToReturn.reduce(0) { $0 + $1.quantity }
    }
    
    func add(_ item: CartItem) async {
        addCalled = true
        if let index = itemsToReturn.firstIndex(where: { $0.product.id == item.product.id }) {
            itemsToReturn[index].quantity += item.quantity
        } else {
            itemsToReturn.append(item)
        }
    }
    
    func remove(at index: Int) async {
        removeCalled = true
        if itemsToReturn.indices.contains(index) {
            itemsToReturn.remove(at: index)
        }
    }
    
    func clear() async {
        clearCalled = true
        itemsToReturn.removeAll()
    }
}
