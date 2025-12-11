//
//  CartItem.swift
//  ShoppingApp
//
//  Created by Akshat Gandhi on 11/12/25.
//
import Foundation

struct CartItem: Identifiable, Equatable, Sendable {
    let id: UUID
    let product: Product
    var quantity: Int
    
    init(id: UUID = UUID(), product: Product, quantity: Int = 1) {
        self.id = id
        self.product = product
        self.quantity = quantity
    }
    
    var totalPrice: Double {
        product.price * Double(quantity)
    }
}
