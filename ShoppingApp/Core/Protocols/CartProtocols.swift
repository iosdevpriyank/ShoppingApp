//
//  CartProtocols.swift
//  ShoppingApp
//
//  Created by Akshat Gandhi on 11/12/25.
//

protocol CartReadable: Sendable {
    func items() async -> [CartItem]
    func itemCount() async -> Int
}

protocol CartWritable: Sendable {
    func add(_ item: CartItem) async
    func remove(at index: Int) async
    func clear() async
}
