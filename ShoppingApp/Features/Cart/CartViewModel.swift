//
//  CartViewModel.swift
//  ShoppingApp
//
//  Created by Akshat Gandhi on 11/12/25.
//

import Foundation

@Observable
@MainActor

final class CartViewModel {
    var items: [CartItem] = []
    var subtotal: Double = 0
    var totalPrice: Double = 0
    var discountAmount: Double = 0
    var isLoading = false
    
    var discountPercentage: Int {
        discount.discountPercentage(for: subtotal)
    }
    
    private let cart: CartReadable & CartWritable
    private let discount: DiscountEngine
    private let analytics: AnalyticsProtocol
    
    init(cart: (CartReadable & CartWritable)? = nil, discount: DiscountEngine? = nil, analytics: AnalyticsProtocol? = nil) {
        self.cart = cart ?? CartStore.shared
        self.discount = discount ?? DiscountEngine()
        self.analytics = analytics ?? AnalyticsLogger.shared
    }
    
    func loadCart() async {
        isLoading = true
        items = await cart.items()
        calculateTotal()
        await analytics.logScreenView("cart")
        isLoading = false
    }
    
    func addProduct(_ product: Product) async {
        let item = CartItem(product: product, quantity: 1)
        await cart.add(item)
        await loadCart()
        await analytics.logEvent("add_to_cart", parameters: [
            "product_id": product.id,
            "product_name": product.name,
            "price": product.price
        ])
    }
    
    func removeItem(at index: Int) async {
        guard items.indices.contains(index) else { return }
        let item = items[index]
        
        await cart.remove(at: index)
        items.remove(at: index)
        calculateTotal()
        
        await analytics.logEvent("remove_from_cart", parameters: [
            "product_id": item.product.id
        ])
    }
    
    func clearCart() async {
        await cart.clear()
        items.removeAll()
        calculateTotal()
        await analytics.logEvent("cart_cleared", parameters: [:])
    }
    
    private func calculateTotal() {
        subtotal = items.reduce(0) { $0 + $1.totalPrice }
        totalPrice = discount.calculate(subtotal: subtotal)
        discountAmount = subtotal - totalPrice
    }
    
}
