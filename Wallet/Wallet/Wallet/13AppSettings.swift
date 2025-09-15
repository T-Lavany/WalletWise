import SwiftUI

struct settingsView: View {
    @State private var notificationsEnabled = true
    @State private var showingDeleteConfirmation = false
    @State private var showingLogoutConfirmation = false
    @State private var navigateToWelcome = false

    var body: some View {
        NavigationStack {
            List {
                // App Information Section
                Section(header: Text("App Information")) {
                    NavigationLink(destination: HowToUseView()) {
                        Label("How to Use", systemImage: "questionmark.circle")
                    }

                    NavigationLink(destination: FeedbackView()) {
                        Label("Send Feedback", systemImage: "envelope")
                    }

                    NavigationLink(destination: ContactUsView()) {
                        Label("Contact Us", systemImage: "person.circle")
                    }
                }

                // Preferences Section
                Section(header: Text("Preferences")) {
                    Toggle(isOn: $notificationsEnabled) {
                        Label("Notifications", systemImage: "bell")
                    }

                    NavigationLink(destination: LanguageSettingsView()) {
                        Label("Language", systemImage: "globe")
                    }
                }

                // Account Section
                Section(header: Text("Account")) {
                    Button(action: {
                        showingLogoutConfirmation = true
                    }) {
                        Label("Logout", systemImage: "arrow.right.square")
                            .foregroundColor(.red)
                    }

                    Button(action: {
                        showingDeleteConfirmation = true
                    }) {
                        Label("Delete Account", systemImage: "person.crop.circle.badge.minus")
                            .foregroundColor(.red)
                    }
                }

                // About Section
                Section(header: Text("About")) {
                    NavigationLink(destination: TermsOfServiceView()) {
                        Label("Terms of Service", systemImage: "doc.text")
                    }

                    NavigationLink(destination: PrivacyPolicyView()) {
                        Label("Privacy Policy", systemImage: "hand.raised")
                    }

                    HStack {
                        Label("Version", systemImage: "info.circle")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.gray)
                    }
                }
            }
            

            .alert("Logout", isPresented: $showingLogoutConfirmation) {
                Button("Cancel", role: .cancel) {}
                Button("Logout", role: .destructive) {
                    // Add logout logic here
                    UserDefaults.standard.set("", forKey: "username")
                    navigateToWelcome = true
                    
                }
             
            } message: {
                Text("Are you sure you want to logout?")
            }

            .alert("Delete Account", isPresented: $showingDeleteConfirmation) {
                Button("Cancel", role: .cancel) {}
                Button("Delete", role: .destructive) {
                    // Add account deletion logic here
                    UserDefaults.standard.set("", forKey: "username")
                    navigateToWelcome = true
                }
            } message: {
                Text("Are you sure you want to delete your account? This action cannot be undone.")
            }

            // Navigation to WelcomePage
            NavigationLink(destination: WelcomeView(), isActive: $navigateToWelcome) {
                EmptyView()
            
            }
        }
    }
}

#Preview {
    settingsView()
}

