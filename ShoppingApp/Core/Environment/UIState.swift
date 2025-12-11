//
//  UIState.swift
//  ShoppingApp
//
//  Created by Akshat Gandhi on 11/12/25.
//
import Foundation

@Observable
@MainActor
final class UIState {
    static let shared = UIState()
    
    var isLoggedIn = false
    var currentUser: User?
    var selectedTab: Tab = .products
    var showCart = false
    
    enum Tab {
        case products
        case cart
        case profile
    }
}
