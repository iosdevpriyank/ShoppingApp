//
//  AppEnvironment.swift
//  ShoppingApp
//
//  Created by Akshat Gandhi on 11/12/25.
//
import Foundation

@MainActor
final class AppEnvironment {
    static let shared = AppEnvironment()
    
    let ui: UIState
    let productAPI: ProductAPI
    let cartStore: CartReadable & CartWritable
    let analytics: AnalyticsProtocol
    
    init(ui: UIState? = nil, productAPI: ProductAPI? = nil, cartStore: (CartReadable & CartWritable)? = nil, analytics: AnalyticsProtocol? = nil) {
        self.ui = ui ?? UIState.shared
        self.productAPI = productAPI ?? RealProductAPI.shared
        self.cartStore = cartStore ?? CartStore.shared
        self.analytics = analytics ?? AnalyticsLogger.shared
    }
}
