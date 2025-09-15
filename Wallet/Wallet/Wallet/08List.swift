import SwiftUI

struct transactionListView: View {
    @State private var transactions: [listresponsedata] = []
    @State private var sortOption: SortOption = .byDate

    enum SortOption: String, CaseIterable, Identifiable {
        case byDate = "Date"
        case byAmount = "Amount"

        var id: String { self.rawValue }
    }

    // MARK: - Icon & Color Mapping
    func iconForCategory(_ category: String) -> (icon: String, color: Color) {
        switch category {
        case "Salary":
            return ("banknote", .green)
        case "Business":
            return ("briefcase", .green)
        case "Loan":
            return ("creditcard", .green)
        case "Others":
            return ("square.grid.2x2", .green)
        default:
            return ("circle", .red)
        }
    }

    var sortedTransactions: [listresponsedata] {
        switch sortOption {
        case .byDate:
            return transactions.sorted { $0.date > $1.date } // assuming date is a string in "YYYY-MM-DD" format
        case .byAmount:
            return transactions.sorted { $0.amount > $1.amount }
        }
    }

    var body: some View {
        VStack {
            // Header
            HStack {
                Text("Transaction List")
                    .font(.custom("SF Pro", size: 30).weight(.bold))
                    .padding(.leading, 115)
                    .padding(.top, 10)
                Spacer()
            }
            .padding()
            .background(Color.pink.opacity(0.7))
            .foregroundColor(.black)

            // Sort Picker
            Picker("Sort by", selection: $sortOption) {
                ForEach(SortOption.allCases) { option in
                    Text(option.rawValue)
                        .font(.custom("SF Pro", size: 16).weight(.bold))
                        .tag(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            // Transactions
            if transactions.isEmpty {
                Text("Loading transactions...")
                    .font(.custom("SF Pro", size: 16).weight(.bold))
                    .foregroundColor(.gray)
                    .onAppear {
                        fetchTransactions()
                    }
            } else {
                List(sortedTransactions, id: \.id) { txn in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            // Icon with color
                            let iconData = iconForCategory(txn.category)
                            Image(systemName: iconData.icon)
                                .foregroundColor(iconData.color)
                                .font(.title3)

                            VStack(alignment: .leading, spacing: 6) {
                                Text(txn.category)
                                    .font(.custom("SF Pro", size: 22).weight(.bold))
                                Text(txn.date)
                                    .font(.custom("SF Pro", size: 14).weight(.bold))
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text("₹ \(txn.amount)")
                                .font(.custom("SF Pro", size: 18).weight(.bold))
                                .foregroundColor(iconData.color)
                        }

                        if !txn.note.isEmpty {
                            Text("Note: \(txn.note)")
                                .font(.custom("SF Pro", size: 14).weight(.bold))
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 6)
                }
            }
        }
    }

    func fetchTransactions() {
        let params = ["email": Datamanager.shared.email]
        APIHandler.shared.postAPIValues(
            type: listresponsemodel.self,
            apiUrl: APIList.listUrl,
            method: "POST",
            formData: params
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if response.status {
                        self.transactions = response.data
                    } else {
                        print("Error: \(response.message)")
                    }
                case .failure(let error):
                    print("API error:", error)
                }
            }
        }
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaults.standard.set("preview@example.com", forKey: "email")
        return transactionListView()
    }
}
