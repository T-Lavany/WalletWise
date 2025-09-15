//
//  Alert.swift
//  Wallet
//
//  Created by SAIL on 31/05/25.
//


import SwiftUI
import Combine

class AlertManager: ObservableObject {
    static let shared = AlertManager() // Singleton instance
    
    @Published var showAlert = false
    @Published var message = ""
    @Published var title = "Notice"

    private init() {}

    func show(message: String, title: String = "Notice") {
        self.title = title
        self.message = message
        self.showAlert = true
    }
}



struct GlobalAlertModifier: ViewModifier {
    @ObservedObject var alertManager = AlertManager.shared

    func body(content: Content) -> some View {
        content
            .alert(alertManager.title, isPresented: $alertManager.showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertManager.message)
            }
    }
}

extension View {
    func withGlobalAlert() -> some View {
        self.modifier(GlobalAlertModifier())
    }
}


