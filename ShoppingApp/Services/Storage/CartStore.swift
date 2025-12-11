//
//  CartStore.swift
//  ShoppingApp
//
//  Created by Akshat Gandhi on 11/12/25.
//


import Foundation

actor CartStore: CartReadable, CartWritable {
    static let shared = CartStore()
    
    private var items: [CartItem] = []
    
    func items() async -> [CartItem] {
        items
    }
    
    func itemCount() async -> Int {
        items.reduce(0) { $0 + $1.quantity }
    }
    
    func add(_ item: CartItem) async {
        if let index = items.firstIndex(where: { $0.product.id == item.product.id }) {
            items[index].quantity += item.quantity
        } else {
            items.append(item)
        }
    }
    
    func remove(at index: Int) async {
        guard items.indices.contains(index) else { return }
        items.remove(at: index)
    }
    
    func clear() async {
        items.removeAll()
    }
}