//
//  CartItemRow.swift
//  ShoppingApp
//
//  Created by Akshat Gandhi on 12/12/25.
//

import SwiftUI

struct CartItemRow: View {
    let item: CartItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4.0) {
                Text(item.product.name)
                    .font(.headline)
                Text("Qty: \(item.quantity)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text("₹\(item.totalPrice, specifier: "%.2f")")
                .font(.subheadline)
                .bold()
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    CartItemRow(item: CartItem(id: UUID(), product: Product.mock1, quantity: 1))
}
