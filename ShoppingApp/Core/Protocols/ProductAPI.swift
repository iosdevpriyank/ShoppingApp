//
//  ProductAPI.swift
//  ShoppingApp
//
//  Created by Akshat Gandhi on 11/12/25.
//

import Foundation

protocol ProductAPI: Sendable {
    func fetchProducts() async throws -> [Product]
    func searchProducts(query: String) async throws -> [Product]
    func fetchProduct(id: String) async throws -> Product
}
