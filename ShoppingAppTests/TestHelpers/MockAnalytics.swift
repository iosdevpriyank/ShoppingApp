//
//  MockAnalytics.swift
//  ShoppingApp
//
//  Created by Akshat Gandhi on 12/12/25.
//


import Foundation
@testable import ShoppingApp

final class MockAnalytics: AnalyticsProtocol, @unchecked Sendable {
    var eventsLogged: [(name: String, parameters: [String: Any])] = []
    var screenViewsLogged: [String] = []
    
    func logEvent(_ name: String, parameters: [String: Any] = [:]) async {
        eventsLogged.append((name, parameters))
    }
    
    func logScreenView(_ screenName: String) async {
        screenViewsLogged.append(screenName)
        await logEvent("screen_view", parameters: ["screen_name": screenName])
    }
}
