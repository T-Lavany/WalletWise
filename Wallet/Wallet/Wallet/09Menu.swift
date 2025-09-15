import SwiftUI

struct AppMenuScreen: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                HStack {
                    Spacer()

                    Text("WalletWise")
                        .font(.custom("SF Pro Display Bold", size: 28)) // ✅ Changed to SF Pro Bold
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

                    // ✅ NEW MENU ITEM
                    NavigationLink(destination: DailyEntryView()) {  // <-- new view
                        MenuButton(title: "Daily Entry")  // <-- new name
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

// ✅ Reusable button view
struct MenuButton: View {
    var title: String

    var body: some View {
        Text(title)
            .font(.custom("SF Pro Display Bold", size: 24))
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.pink.opacity(0.6))
            .cornerRadius(40)
    }
}

// ✅ NEW VIEW FOR DAILY ENTRY (TEMP PLACEHOLDER)
struct dailyEntryView: View {
    var body: some View {
        Text("Daily Entry Screen")
            .font(.largeTitle)
            .padding()
    }
}

struct MenuScreen_Previews: PreviewProvider {
    static var previews: some View {
        AppMenuScreen()
    }
}
