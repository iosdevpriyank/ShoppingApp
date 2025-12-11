//
//  ProfileView.swift
//  ShoppingApp
//
//  Created by Akshat Gandhi on 12/12/25.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var uiState = UIState.shared
    
    var body: some View {
        NavigationView {
            List {
                if uiState.isLoggedIn, let user = uiState.currentUser {
                    Section {
                        Text(user.name)
                            .font(.headline)
                        Text(user.email)
                            .foregroundColor(.secondary)
                    }
                    
                    Section {
                        Button("Logout") {
                            uiState.isLoggedIn = false
                            uiState.currentUser = nil
                        }
                        .foregroundColor(.red)
                    }
                } else {
                    Section {
                        Button("Login") {
                            // Simulate login
                            uiState.isLoggedIn = true
                            uiState.currentUser = User.mock
                        }
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
}
