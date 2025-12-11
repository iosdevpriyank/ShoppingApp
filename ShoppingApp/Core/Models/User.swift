//
//  User.swift
//  ShoppingApp
//
//  Created by Akshat Gandhi on 11/12/25.
//


struct User: Codable, Equatable, Sendable {
    let id: String
    let email: String
    let name: String
    
    static let mock = User(
        id: "123",
        email: "iosdev.priyank@gmail.com",
        name: "Priaynk Gandhi"
    )
}
