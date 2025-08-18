import SwiftUI

struct AppMenuScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isAdmin: Bool = true

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 24) {
                // Header with back button
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding()
                    }

                    Spacer()

                    Text("WalletWise")
                        .font(.custom("Futura-Bold", size: 24))
                        .foregroundColor(.red)
                        .padding(.top, 50)

                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 20)

                Divider()
                    .background(Color.black)
                    .padding(.horizontal)

                // Buttons
                VStack(spacing: 50) {
                    NavigationLink(destination: BudgetGoalsView()) {
                        AppMenuButton(title: "Budget Goals")
                    }

                    NavigationLink(destination: RateAppView()) {
                        AppMenuButton(title: "Rate App")
                    }

                    NavigationLink(destination: SettingsView()) {
                        AppMenuButton(title: "App Settings")
                    }

                    if isAdmin {
                        NavigationLink(destination: AdminLoginView()) {
                            AppMenuButton(title: "Admin Login")
                        }
                    }
                }
                .padding(.top, 50)
                .padding(.horizontal)

                Spacer()
            }
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AppMenuButton: View {
    var title: String

    var body: some View {
        Text(title)
            .font(.system(size: 20, weight: .medium, design: .serif))
            .italic()
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.pink.opacity(0.6))
            .cornerRadius(40)
    }
}

// MARK: - Placeholder Views
struct budgetGoalsView: View { var body: some View { Text("Budget Goals View") } }
struct rateAppView: View { var body: some View { Text("Rate App View") } }
struct appSettingsView: View { var body: some View { Text("App Settings View") } }
struct adminLoginView: View { var body: some View { Text("Admin Login View") } }

struct AppMenuScreen_Previews: PreviewProvider {
    static var previews: some View {
        AppMenuScreen()
    }
}
