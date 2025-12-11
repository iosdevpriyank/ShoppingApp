//
//  Product.swift
//  ShoppingApp
//
//  Created by Akshat Gandhi on 11/12/25.
//


struct Product: Identifiable, Codable, Equatable, Sendable {
    let id: String
    let name: String
    let description: String
    let price: Double
    let imageURL: String?
    let category: String
    
    static let mock1 = Product(
        id: "1",
        name: "Wireless Headphones",
        description: "Premium noise-cancelling headphones",
        price: 299.99,
        imageURL: nil,
        category: "Electronics"
    )
    
    static let mock2 = Product(
        id: "2",
        name: "Smart Watch",
        description: "Fitness tracking smartwatch",
        price: 399.99,
        imageURL: nil,
        category: "Electronics"
    )
    
    static let mock3 = Product(
        id: "3",
        name: "Coffee Maker",
        description: "Programmable coffee maker",
        price: 89.99,
        imageURL: nil,
        category: "Home"
    )
}
