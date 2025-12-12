//
//  CartView.swift
//  ShoppingApp
//
//  Created by Akshat Gandhi on 12/12/25.
//

import SwiftUI

struct CartView: View {
    @State private var cartVM = CartViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if cartVM.isLoading {
                  ProductsView()
                } else if cartVM.items.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "cart")
                            .font(.system(size: 60.0))
                            .foregroundStyle(.secondary)
                        Text("Your cart is empty")
                            .font(.headline)
                        Text("Add Products to continue")
                            .foregroundStyle(.secondary)
                    }
                } else {
                    List {
                        ForEach(cartVM.items) { item in
                            CartItemRow(item: item)
                        }
                        .onDelete { indexSet in
                            Task {
                                for index in indexSet {
                                    await cartVM.removeItem(at: index)
                                }
                            }
                        }
                        
                        
                        Section {
                            HStack {
                                Text("SubTotal:")
                                Spacer()
                                Text("₹\(cartVM.subtotal, specifier: "%.2f")")
                            }
                            
                            if cartVM.discountAmount > 0 {
                                HStack {
                                    Text("Discount (\(cartVM.discountPercentage)%)")
                                        .foregroundColor(.green)
                                    Spacer()
                                    Text("-₹\(cartVM.discountAmount, specifier: "%.2f")")
                                        .foregroundColor(.green)
                                }
                            }
                            
                            HStack {
                                Text("Total")
                                    .font(.headline)
                                Spacer()
                                Text("₹\(cartVM.totalPrice, specifier: "%.2f")")
                                    .font(.title2)
                                    .bold()
                            }
                        }
                        
                        Section {
                            Button("Clear Cart") {
                                Task {
                                    await cartVM.clearCart()
                                }
                            }
                            .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Cart")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await cartVM.loadCart()
            }
        }
    }
}

#Preview {
    CartView()
}
