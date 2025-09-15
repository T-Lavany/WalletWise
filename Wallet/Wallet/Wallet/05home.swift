import SwiftUI

struct DashboardView: View {
    @AppStorage("username") var username: String = "User" // Retrieved from login system
    @State private var selectedDate = Date()
    @State private var showMenu = false
    @State private var animateWelcome = false

    let budgetTips = [
        "Save before you spend.",
        "Track small expenses.",
        "Cut unused subscriptions.",
        "Use cash over cards.",
        "Wait 24h before big buys.",
        "Plan your monthly budget.",
        "Review spending weekly.",
        "Set a fun money limit.",
        "Avoid shopping when bored.",
        "Cook at home more often."
    ]

    var todaysBudgetTip: String {
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 0
        return budgetTips[dayOfYear % budgetTips.count]
    }

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()

            VStack(spacing: 20) {
                // Header
                HStack {
                    Button(action: {
                        showMenu.toggle()
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .font(.system(size: 30))
                            .padding(.leading)
                    }

                    Spacer()

                    Text("WalletWise")
                        .font(.custom("Arial Rounded MT Bold", size: 24))
                        .foregroundColor(.red)

                    Spacer()

                    NavigationLink(destination: settingsView()) {
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 30))
                            .padding(.trailing)
                    }
                }
                .padding(.top)

                // Animated Welcome Message
                HStack {
                    Text("👋 Welcome back, \(username)!")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .opacity(animateWelcome ? 1 : 0)
                        .offset(x: animateWelcome ? 0 : -20)
                        .animation(.easeOut(duration: 1.0), value: animateWelcome)
                    Spacer()
                }
                .padding(.horizontal)
                .onAppear {
                    animateWelcome = true
                }

                // Date Picker
                DatePicker(
                    selection: $selectedDate,
                    displayedComponents: [.date],
                    label: {
                        HStack(spacing: 5) {
                            Image(systemName: "calendar")
                            Text(formattedFullDate)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.pink.opacity(0.3))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                    }
                )
                .datePickerStyle(.compact)
                .padding(.horizontal)

                // List Button
                HStack {
                    Spacer()
                    NavigationLink(destination: transactionListView()) {
                        Label("List", systemImage: "list.bullet")
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.trailing)
                }

                // Smart Suggestions + Tip
                VStack(spacing: 25) {
                    // Smart Suggestions
                    VStack(spacing: 15) {
                        Image(systemName: "lightbulb.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.yellow.opacity(0.8))

                        Text("Let’s get started!")
                            .font(.headline)

                        Text("Add your first CashIn or CashOut to begin tracking your money.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        HStack(spacing: 20) {
                            NavigationLink(destination: CashInView()) {
                                Text("➕ Add Credit")
                                    .padding()
                                    .background(Color.green.opacity(0.9))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }

                            NavigationLink(destination: CashOutView()) {
                                Text("➖ Add Debit")
                                    .padding()
                                    .background(Color.red.opacity(0.9))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }

                    Divider().padding(.horizontal)

                    // Budget Tip of the Day
                    VStack(spacing: 10) {
                        Image(systemName: "book.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.blue.opacity(0.7))

                        Text("💡 Tip of the Day")
                            .font(.headline)

                        Text("“\(todaysBudgetTip)”")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .italic()
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .shadow(radius: 5)
                .padding(.horizontal)

                Spacer()

                // Bottom tab bar
                HStack(spacing: 0) {
                    NavigationLink(destination: CashInView()) {
                        TabItem(image: "wallet.pass.fill", title: "Credit", isActive: true)
                    }

                    NavigationLink(destination: CashOutView()) {
                        TabItem(image: "creditcard.fill", title: "Debit")
                    }

                    NavigationLink(destination: budgetSummaryView(
                        house: 1000, food: 3000,
                        lifestyle: 2500,
                        entertainment: 2000,
                        others: 1500,
                        totalBudget: 10000
                    )) {
                        TabItem(image: "chart.bar.fill", title: "Summary")
                    }
                }
                .background(Color.white)
                .frame(height: 80)
                .cornerRadius(15)
            }
            .padding(.horizontal)
        }
        .sheet(isPresented: $showMenu) {
            AppMenuScreen()
        }
        .navigationBarBackButtonHidden(true)
    }

    var formattedFullDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: selectedDate)
    }

    @ViewBuilder
    func TabItem(image: String, title: String, isActive: Bool = false) -> some View {
        VStack {
            Image(systemName: image)
                .resizable()
                .frame(width: 25, height: 25)
                .padding(4)
            Text(title)
                .font(.custom("Arial Rounded MT Bold", size: 14))
        }
        .frame(maxWidth: .infinity)
        .background(isActive ? Color.yellow.opacity(0.3) : Color.clear)
    }
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DashboardView()
                .previewDevice("iPhone 14")
            DashboardView()
                .previewDevice("iPad Pro (12.9-inch) (6th generation)")
        }
    }
}
