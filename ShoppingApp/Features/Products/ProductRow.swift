//
//  ProductRow.swift
//  ShoppingApp
//
//  Created by Akshat Gandhi on 11/12/25.
//

import SwiftUI

struct ProductRow: View {
    let product: Product
    let onAddToCart: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.headline)
                Text(product.description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("₹\(product.price, specifier: "%.2f")")
                    .font(.subheadline)
                    .bold()
            }
            Spacer()
            
            Button(action: onAddToCart) {
                Image(systemName: "cart.badge.plus")
                    .font(.title3)
            }
            .buttonStyle(.borderless)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ProductRow(product: Product.mock1) {
        print("Added to cart!")
    }
}
