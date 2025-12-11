//
//  RealProductAPI.swift
//  ShoppingApp
//
//  Created by Akshat Gandhi on 11/12/25.
//
import Foundation

final class RealProductAPI: ProductAPI {
    static let shared = RealProductAPI()
    
    private let baseURL = "https://api.example.com"
    
    func fetchProducts() async throws -> [Product] {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        // Return mock data for demo
        return [
            Product.mock1,
            Product.mock2,
            Product.mock3,
            Product(
                id: "4",
                name: "Running Shoes",
                description: "Comfortable athletic shoes",
                price: 129.99,
                imageURL: nil,
                category: "Sports"
            ),
            Product(
                id: "5",
                name: "Backpack",
                description: "Durable travel backpack",
                price: 79.99,
                imageURL: nil,
                category: "Travel"
            )
        ]
    }
    
    func searchProducts(query: String) async throws -> [Product] {
        let allProducts = try await fetchProducts()
        return allProducts.filter { 
            $0.name.localizedCaseInsensitiveContains(query) ||
            $0.description.localizedCaseInsensitiveContains(query)
        }
    }
    
    func fetchProduct(id: String) async throws -> Product {
        let products = try await fetchProducts()
        guard let product = products.first(where: { $0.id == id }) else {
            throw APIError.productNotFound
        }
        return product
    }
    
    enum APIError: Error {
        case productNotFound
        case networkError
    }
}
