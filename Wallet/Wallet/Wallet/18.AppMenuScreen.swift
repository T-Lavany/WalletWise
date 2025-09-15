import SwiftUI

struct menuScreen: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                HStack {
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

                // Menu Buttons
                VStack(spacing: 40) {
                    NavigationLink(destination: BudgetGoalsView()) {
                        MenuButton(title: "Budget Goals")
                    }

                  
                    NavigationLink(destination: RateAppView()) {
                        MenuButton(title: "Rate App")
                    }

                    NavigationLink(destination: settingsView()) {
                        MenuButton(title: "App Settings")
                    }

                    NavigationLink(destination: AdminLoginView()) {
                        MenuButton(title: "Admin Login")
                    }
                }
                .padding(.top, 50)
                .padding(.horizontal)

                Spacer()
            }
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.black)
            })
        }
    }
}

// MARK: - Menu Button UI
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

// MARK: - Dummy Placeholder Views (You can replace with your real views)
struct budgetGoalsView: View {
    var body: some View {
        Text("📊 Budget Goals Screen")
            .font(.title2)
            .padding()
    }
}

struct rateAppView: View {
    var body: some View {
        Text("⭐️ Rate App Screen")
            .font(.title2)
            .padding()
    }
}

struct SettingView: View {
    var body: some View {
        Text("⚙️ App Settings Screen")
            .font(.title2)
            .padding()
    }
}

struct AdminLoginView: View {
    var body: some View {
        AdminLoginScreen()
    }
}

// MARK: - Preview
struct menuScreen_Previews: PreviewProvider {
    static var previews: some View {
        AppMenuScreen()
    }
}
