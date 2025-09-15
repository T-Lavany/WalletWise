import SwiftUI

// MARK: - Model for expense
struct ExpenseItem: Identifiable, Codable, Equatable {
    let id = UUID()
    var category: String
    var amount: Double
}

// MARK: - Formatter for rupees
extension NumberFormatter {
    static var rupees: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "₹"
        formatter.maximumFractionDigits = 2
        return formatter
    }
}

// MARK: - Helper to hide keyboard
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct DailyEntryView: View {
    // ✅ Fixed monthly budget
    @AppStorage("fixedMonthlyBudget") private var fixedMonthlyBudget: Double = 2000.0
    
    // ✅ Selected date from calendar
    @State private var selectedDate = Date()
    @State private var showCalendar = false // toggle for showing calendar
    
    // ✅ Dictionary: Date -> [ExpenseItem]
    @AppStorage("allExpenses") private var allExpensesData: Data = Data()
    @State private var allExpenses: [String: [ExpenseItem]] = [:]  // keyed by date string
    
    // ✅ Add new expense for selected date
    @State private var newCategory = ""
    @State private var newAmount: String = ""
    
    // ✅ Motivational quotes depending on spending %
    private let quotes = [
        "Great start! Keep saving smartly.",
        "You're approaching your monthly limit.",
        "Small savings add up to big results.",
        "Budget alert! Consider reducing spending."
    ]
    
    // ✅ Formatter for date keys
    private var dateKey: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: selectedDate)
    }
    
    // ✅ Computed values
    var totalSpent: Double {
        allExpenses.values.flatMap { $0 }.reduce(0) { $0 + $1.amount }
    }
    
    var percentSpent: Double {
        min(totalSpent / fixedMonthlyBudget, 1.0)
    }
    
    var currentQuote: String {
        switch percentSpent {
        case 0..<0.5:
            return quotes[0]
        case 0.5..<0.8:
            return quotes[1]
        case 0.8..<1.0:
            return quotes[2]
        default:
            return quotes[3]
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Title
                Text("Daily Spend")
                    .font(.title)
                    .bold()
                    .padding(.top)
                
                // Calendar (collapsible)
                VStack(alignment: .leading) {
                    Text("Select Date")
                        .font(.headline)
                    
                    Button(action: {
                        withAnimation {
                            showCalendar.toggle()
                        }
                    }) {
                        HStack {
                            Text("\(dateKey)")
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: showCalendar ? "chevron.up" : "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                    }
                    
                    if showCalendar {
                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 2)
                            .padding(.top, 5)
                    }
                }
                .padding(.horizontal)
                
                // Progress bar
                VStack(alignment: .leading) {
                    Text("\(Int(percentSpent * 100))% of monthly budget spent")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    ProgressView(value: percentSpent)
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        .frame(height: 10)
                        .cornerRadius(5)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 2)
                
                // Amount saved
                VStack {
                    Text("₹\(String(format: "%.2f", fixedMonthlyBudget - totalSpent))")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.black)
                    Text("Amount Saved This Month")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 2)
                
                // Budget alert and quote
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.orange)
                        Text("Budget Alert!")
                            .font(.headline)
                    }
                    Text(currentQuote)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 2)
                
                // Expenses for selected date
                VStack(alignment: .leading, spacing: 12) {
                    Text("Expenses on \(dateKey)")
                        .font(.headline)
                    
                    if let expenses = allExpenses[dateKey], !expenses.isEmpty {
                        ForEach(expenses) { expense in
                            HStack {
                                Text(expense.category)
                                Spacer()
                                Text("₹\(String(format: "%.2f", expense.amount))")
                                    .bold()
                            }
                            .padding(8)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        }
                    } else {
                        Text("No expenses added yet for this date")
                            .foregroundColor(.gray)
                    }
                    
                    // Add new expense input
                    VStack(spacing: 10) {
                        TextField("Category (e.g. Groceries)", text: $newCategory)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Amount", text: $newAmount)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: addExpenseForSelectedDate) {
                            Text("Add Expense")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.top)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 2)
                
                // Fixed Budget Setter
                VStack(alignment: .leading, spacing: 10) {
                    Text("Set Monthly Budget (Fixed Once)")
                        .font(.headline)
                    HStack {
                        TextField("Enter budget", value: $fixedMonthlyBudget, formatter: NumberFormatter.rupees)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button("Lock") {
                            hideKeyboard()
                        }
                        .padding(.horizontal)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 2)
            }
            .padding()
            .background(Color(.systemGray6))
        }
        .onAppear {
            loadExpenses()
        }
        .onChange(of: allExpenses) { _ in
            saveExpenses()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // ✅ Add expense for selected date
    func addExpenseForSelectedDate() {
        guard let amount = Double(newAmount), !newCategory.isEmpty else { return }
        var expensesForDate = allExpenses[dateKey] ?? []
        let expense = ExpenseItem(category: newCategory, amount: amount)
        expensesForDate.append(expense)
        allExpenses[dateKey] = expensesForDate
        newCategory = ""
        newAmount = ""
    }
    
    // ✅ Save & load expenses using JSON
    func saveExpenses() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(allExpenses) {
            allExpensesData = data
        }
    }
    
    func loadExpenses() {
        let decoder = JSONDecoder()
        if let loaded = try? decoder.decode([String: [ExpenseItem]].self, from: allExpensesData) {
            allExpenses = loaded
        }
    }
}

// MARK: - Preview
struct DailyEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DailyEntryView()
        }
    }
}
