//
//  AnalyticsLogger.swift
//  ShoppingApp
//
//  Created by Akshat Gandhi on 11/12/25.
//


import Foundation

actor AnalyticsLogger: AnalyticsProtocol {
    static let shared = AnalyticsLogger()
    
    private var events: [(name: String, parameters: [String: Any], timestamp: Date)] = []
    
    func logEvent(_ name: String, parameters: [String: Any] = [:]) {
        let event = (name: name, parameters: parameters, timestamp: Date())
        events.append(event)
        print("Analytics: \(name) - \(parameters)")
    }
    
    func logScreenView(_ screenName: String) {
        logEvent("screen_view", parameters: ["screen_name": screenName])
    }
}
