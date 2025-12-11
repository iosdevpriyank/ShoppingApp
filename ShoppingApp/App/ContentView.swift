//
//  ContentView.swift
//  ShoppingApp
//
//  Created by Akshat Gandhi on 11/12/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: UIState.Tab = .products
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ProductsView().tabItem {
                Label("Products", systemImage: "list.bullet")
            }
            .tag(UIState.Tab.products)
            
            CartView().tabItem {
                Label("Cart", systemImage: "cart")
            }
            .tag(UIState.Tab.cart)
            
            ProfileView().tabItem {
                Label("Profile", systemImage: "person")
            }
            .tag(UIState.Tab.profile)
        }
    }
}

#Preview {
    ContentView()
}
