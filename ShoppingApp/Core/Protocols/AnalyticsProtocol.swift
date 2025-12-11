//
//  AnalyticsProtocol.swift
//  ShoppingApp
//
//  Created by Akshat Gandhi on 11/12/25.
//
import Foundation

protocol AnalyticsProtocol: Sendable {
    func logEvent(_ name: String, parameters: [String: Any]) async
    func logScreenView(_ screenName: String) async
}
