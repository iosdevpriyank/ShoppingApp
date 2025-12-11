//
//  DiscountEngine.swift
//  ShoppingApp
//
//  Created by Akshat Gandhi on 11/12/25.
//


import Foundation

struct DiscountEngine {
    func calculate(subtotal: Double) -> Double {
        if subtotal >= 200 {
            return subtotal * 0.85 // 15% off
        } else if subtotal >= 100 {
            return subtotal * 0.90 // 10% off
        }
        return subtotal
    }
    
    func discountPercentage(for subtotal: Double) -> Int {
        if subtotal >= 200 {
            return 15
        } else if subtotal >= 100 {
            return 10
        }
        return 0
    }
}