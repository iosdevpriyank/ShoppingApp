//
//  ProductsViewModel.swift
//  ShoppingApp
//
//  Created by Akshat Gandhi on 11/12/25.
//

import Foundation

@Observable
@MainActor
final class ProductsViewModel {
    var products: [Product] = []
    var isLoading: Bool = false
    var errorMessage: String?
    var searchQuery: String = ""
    
    private let productAPI: ProductAPI
    private let analytics: AnalyticsProtocol
    
    init(productAPI: ProductAPI? = nil, analytics: AnalyticsProtocol? = nil) {
        self.productAPI = productAPI ?? RealProductAPI.shared
        self.analytics = analytics ?? AnalyticsLogger.shared
    }
    
    func loadProducts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            products = try await productAPI.fetchProducts()
            await analytics.logScreenView("products")
        } catch {
            errorMessage = "Failed to load products: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func searchProducts() async {
        guard !searchQuery.isEmpty else {
            await loadProducts()
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            products = try await productAPI.searchProducts(query: searchQuery)
            await analytics.logEvent("search", parameters: ["query": searchQuery])
        } catch {
            errorMessage = "Failed to search products: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    
}

