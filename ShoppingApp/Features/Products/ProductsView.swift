//
//  ProductsView.swift
//  ShoppingApp
//
//  Created by Akshat Gandhi on 11/12/25.
//

import SwiftUI

struct ProductsView: View {
    @State private var productsVM = ProductsViewModel()
    @State private var cartVM = CartViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if productsVM.isLoading {
                    ProgressView("Loading Products...")
                } else if let errorMessage = productsVM.errorMessage {
                    VStack {
                        Text("Error")
                            .font(.headline)
                        Text(errorMessage)
                            .foregroundStyle(.secondary)
                        Button("Retry") {
                            Task {
                                await productsVM.loadProducts()
                            }
                        }
                    }
                } else {
                    List(productsVM.products) { product in
                        ProductRow(product: product) {
                            Task {
                                await cartVM.addProduct(product)
                            }
                        }
                    }
                    .searchable(text: $productsVM.searchQuery)
                    .onChange(of: productsVM.searchQuery) { _, _ in
                        Task {
                            try? await Task.sleep(nanoseconds: 300_000_000)
                            await productsVM.searchProducts()
                        }
                    }
                    
                }
            }
            .navigationTitle("Products")
            .task {
                await productsVM.loadProducts()
            }
        }
    }
}

#Preview {
    ProductsView()
}
