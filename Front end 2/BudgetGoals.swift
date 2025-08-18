import SwiftUI

struct BudgetGoalsView: View {
    @State private var savings: String = ""
    @State private var amount: String = ""
    @State private var income: String = ""

    @State private var house: Int? = nil
    @State private var food: Int? = nil
    @State private var lifestyle: Int? = nil
    @State private var entertainment: Int? = nil
    @State private var others: Int? = nil

    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToSummary = false

    @State private var isBudgetSet = false // Prevent editing once set

    var body: some View {
      
            VStack(spacing: 20) {
                Text("Budget Goals")
                    .font(.largeTitle)
                    .padding()

                HorizontalInputField(label: "💰 Savings:", text: $savings, isDisabled: isBudgetSet)
                HorizontalInputField(label: "📊 Budget:", text: $amount, isDisabled: isBudgetSet)
                HorizontalInputField(label: "💼 Income:", text: $income, isDisabled: isBudgetSet)

                Divider().padding(.top)

                Group {
                    BudgetResultRow(label: "🏠 House", value: house)
                    BudgetResultRow(label: "🍽️ Food", value: food)
                    BudgetResultRow(label: "🛍️ Lifestyle", value: lifestyle)
                    BudgetResultRow(label: "🎮 Entertainment", value: entertainment)
                    BudgetResultRow(label: "📦 Others", value: others)
                }

                Spacer()

                HStack(spacing: 20) {
                    if isBudgetSet {
                        Button("✏️ Edit") {
                            isBudgetSet = false
                            // Reset values to allow re-entry
                            house = nil
                            food = nil
                            lifestyle = nil
                            entertainment = nil
                            others = nil
                            // Uncomment below to reset fields as well
                            // savings = ""
                            // amount = ""
                            // income = ""
                        }
                        .foregroundColor(.orange)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.orange, lineWidth: 1))
                    }

                    Button(isBudgetSet ? "✅ Confirm" : "DONE") {
                        if !isBudgetSet {
                            calculateBudget()
                        } else {
                            navigateToSummary = true
                        }
                    }
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isBudgetSet ? Color.blue : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                }
                .padding(.horizontal)

                NavigationLink(
                    destination: BudgetSummaryView(
                        house: house ?? 0,
                        food: food ?? 0,
                        lifestyle: lifestyle ?? 0,
                        entertainment: entertainment ?? 0,
                        others: others ?? 0,
                        totalBudget: Int(amount) ?? 0
                    ),
                    isActive: $navigateToSummary,
                    label: { EmptyView() }
                )
            }
            .padding()
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            }
        
    }

    func calculateBudget() {
        guard
            let incomeInt = Int(income),
            let savingsInt = Int(savings),
            let budgetInt = Int(amount)
        else {
            alertMessage = "❌ Please enter valid numbers for all fields."
            showAlert = true
            return
        }

        if budgetInt > (incomeInt - savingsInt) {
            alertMessage = "⚠️ Budget exceeds what's available after savings. Please enter a lower budget."
            showAlert = true
            return
        }

        let allocation: [String: Double] = [
            "house": 0.30,
            "food": 0.25,
            "lifestyle": 0.20,
            "entertainment": 0.15,
            "other": 0.10
        ]

        let houseCalc = Int(round(Double(budgetInt) * allocation["house"]!))
        let foodCalc = Int(round(Double(budgetInt) * allocation["food"]!))
        let lifestyleCalc = Int(round(Double(budgetInt) * allocation["lifestyle"]!))
        let entertainmentCalc = Int(round(Double(budgetInt) * allocation["entertainment"]!))
        let otherCalc = budgetInt - (houseCalc + foodCalc + lifestyleCalc + entertainmentCalc)

        house = houseCalc
        food = foodCalc
        lifestyle = lifestyleCalc
        entertainment = entertainmentCalc
        others = otherCalc

        isBudgetSet = true
        alertMessage = "✅ Budget goals setup successful!"
        showAlert = true
    }
}

// MARK: - Reusable Components

struct HorizontalInputField: View {
    var label: String
    @Binding var text: String
    var isDisabled: Bool = false

    var body: some View {
        HStack {
            Text(label)
                .font(.title2)
                .bold()
            Spacer()
            TextField("Enter", text: $text)
                .keyboardType(.numberPad)
                .disabled(isDisabled)
                .multilineTextAlignment(.trailing)
                .frame(width: 140)
                .padding(10)
                .background(Color.gray.opacity(isDisabled ? 0.1 : 0.2))
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}

struct BudgetResultRow: View {
    var label: String
    var value: Int?

    var body: some View {
        HStack {
            Text("\(label):")
                .font(.title3)
                .bold()
            Spacer()
            Text(value != nil ? "₹\(value!)" : "--")
                .font(.title3)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
}

struct BudgetGoalsView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetGoalsView()
    }
}
