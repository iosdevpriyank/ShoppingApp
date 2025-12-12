//
//  MockProductAPI.swift
//  ShoppingApp
//
//  Created by Akshat Gandhi on 12/12/25.
//


import Foundation
@testable import ShoppingApp

final class MockProductAPI: ProductAPI, @unchecked Sendable {
    var productsToReturn: [Product] = []
    var productToReturn: Product?
    var shouldThrowError = false
    var fetchProductsCalled = false
    var searchProductsCalled = false
    
    func fetchProducts() async throws -> [Product] {
        fetchProductsCalled = true
        
        if shouldThrowError {
            throw APIError.networkError
        }
        
        return productsToReturn
    }
    
    func searchProducts(query: String) async throws -> [Product] {
        searchProductsCalled = true
        
        if shouldThrowError {
            throw APIError.networkError
        }
        
        return productsToReturn.filter { 
            $0.name.localizedCaseInsensitiveContains(query)
        }
    }
    
    func fetchProduct(id: String) async throws -> Product {
        if shouldThrowError {
            throw APIError.productNotFound
        }
        
        guard let product = productToReturn else {
            throw APIError.productNotFound
        }
        
        return product
    }
    
    enum APIError: Error {
        case networkError
        case productNotFound
    }
}
