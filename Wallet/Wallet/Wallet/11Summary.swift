import SwiftUI
import Charts

struct BudgetCategory: Identifiable {
    var id = UUID()
    var name: String
    var amount: Int
    var color: Color
}

struct budgetSummaryView: View {
    @State private var isEditing = true // Start in editing mode
    @State private var showingAlert = false
    @State private var alertMessage = ""

    @State var house: Int
    @State var food: Int
    @State var lifestyle: Int
    @State var entertainment: Int
    @State var others: Int
    var totalBudget: Int

    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

    var categories: [BudgetCategory] {
        [
            BudgetCategory(name: "House", amount: house, color: .red),
            BudgetCategory(name: "Food", amount: food, color: .green),
            BudgetCategory(name: "Lifestyle", amount: lifestyle, color: .orange),
            BudgetCategory(name: "Entertainment", amount: entertainment, color: .purple),
            BudgetCategory(name: "Others", amount: others, color: .blue)
        ]
    }

    func percentage(of amount: Int) -> String {
        guard totalBudget > 0 else { return "0.0%" }
        let percent = (Double(amount) / Double(totalBudget)) * 100
        return String(format: "%.1f%%", percent)
    }

    func messageForPercentage(_ percent: Int) -> String {
        switch percent {
        case 0: return " No spending yet! Budget untouched."
        case 1...10: return "Excellent start! Keep tracking wisely."
        case 11...20: return " You're spending mindfully!"
        case 21...30: return "Good pace. Still under control."
        case 31...40: return " Spending gradually, keep an eye."
        case 41...50: return "Halfway there! Stay cautious."
        case 51...60: return " You're over 50%. Budget carefully!"
        case 61...70: return "High usage! Monitor closely."
        case 71...80: return " Nearing limit! Consider reducing."
        case 81...90: return "Very close! Review your expenses."
        case 91...99: return "Critical! Almost over your budget."
        case 100: return  "Perfectly balanced! Spent entire budget."
        default: return " Budget exceeded! Time to adjust."
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                // Header
                HStack {
                    Text(" Budget Summary")
                        .font(.largeTitle)
                        .foregroundColor(.teal)
                        .bold()
                        .padding(.top, -10)
                    Spacer()
                    if isEditing {
                        Button(action: {
                            // Lock editing
                            isEditing = false
                            let totalSpent = house + food + lifestyle + entertainment + others
                            let percent = totalBudget > 0 ? Int((Double(totalSpent) / Double(totalBudget)) * 100) : 0
                            alertMessage = messageForPercentage(percent)
                            showingAlert = true
                        }) {
                            Text("Done")
                                .font(.headline)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.teal.opacity(0.15))
                                .foregroundColor(.teal)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.horizontal)

                // Budget Rows
                VStack(spacing: 12) {
                    ForEach([
                        ("House", $house, percentage(of: house)),
                        ("Food", $food, percentage(of: food)),
                        ("Lifestyle", $lifestyle, percentage(of: lifestyle)),
                        ("Entertainment", $entertainment, percentage(of: entertainment)),
                        ("Others", $others, percentage(of: others))
                    ], id: \.0) { label, binding, percent in
                        BudgetSummaryRow(label: label, value: binding, percentage: percent, isEditing: isEditing, formatter: numberFormatter)
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(15)
                .shadow(radius: 3)
                .padding(.horizontal)

                // Chart Title
                Text("📊 Budget Category Distribution (%)")
                    .font(.headline)
                    .foregroundColor(.indigo)

                // Chart
                Chart {
                    ForEach(categories) { category in
                        let percent = totalBudget > 0 ? (Double(category.amount) / Double(totalBudget)) * 100 : 0.0
                        BarMark(
                            x: .value("Category", category.name),
                            y: .value("Percentage", percent)
                        )
                        .foregroundStyle(category.color)
                        .annotation(position: .top) {
                            Text(String(format: "%.1f%%", percent))
                                .font(.caption)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .frame(height: 300)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(15)
                .shadow(radius: 3)
                .padding(.horizontal)

                // Legend
                HStack(spacing: 15) {
                    ForEach(categories) { category in
                        HStack(spacing: 5) {
                            Circle()
                                .fill(category.color)
                                .frame(width: 10, height: 10)
                            Text(category.name)
                                .font(.caption)
                        }
                    }
                }
                .padding(.horizontal)

                // Total Spent Summary
                let totalSpent = house + food + lifestyle + entertainment + others
                let totalSpentPercentage = totalBudget > 0 ? (Double(totalSpent) / Double(totalBudget)) * 100 : 0.0
                let roundedPercentage = Int(totalSpentPercentage)

                VStack(spacing: 5) {
                    Text("Total Spent: \(totalSpent)")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.primary)
                    Text(String(format: "Used %.1f%% of your total budget", totalSpentPercentage))
                        .font(.caption)
                        .foregroundColor(totalSpentPercentage > 100 ? .red : .green)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.tertiarySystemFill))
                .cornerRadius(12)
                .padding(.horizontal)

                Spacer()
            }
            .padding(.top)
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Budget Feedback"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct BudgetSummaryRow: View {
    var label: String
    @Binding var value: Int
    var percentage: String
    var isEditing: Bool
    var formatter: NumberFormatter

    var body: some View {
        HStack {
            Text(label)
                .font(.title3)
                .bold()
            Spacer()
            if isEditing {
                TextField("Amount", value: $value, formatter: formatter)
                    .keyboardType(.numberPad)
                    .frame(width: 80)
                    .padding(5)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            } else {
                Text("\(value) (\(percentage))")
                    .foregroundColor(.blue)
            }
        }
    }
}

struct budgetSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        budgetSummaryView(
            house: 1000, food: 1000,
            lifestyle: 2500,
            entertainment: 2000,
            others: 1500,
            totalBudget: 10000
        )
    }
}
