import SwiftUI

struct TransactionListView: View {
    @State private var transactions: [listresponsedata] = []
    @State private var sortOption: SortOption = .byDate

    enum SortOption: String, CaseIterable, Identifiable {
        case byDate = "Date"
        case byAmount = "Amount"

        var id: String { self.rawValue }
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
            HStack {
                Text("Transaction List")
                    .font(.title2)
                    .bold()
                    .padding(.leading, 115)
                    .padding(.top,10)
                Spacer()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.black)

            Picker("Sort by", selection: $sortOption) {
                ForEach(SortOption.allCases) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            if transactions.isEmpty {
                Text("Loading transactions...")
                    .foregroundColor(.gray)
                    .onAppear {
                        fetchTransactions()
                    }
            } else {
                List(sortedTransactions, id: \.id) { txn in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(txn.category)
                                    .font(.headline)
                                Text(txn.date)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text("₹ \(txn.amount)")
                                .bold()
                        }

                        if !txn.note.isEmpty {
                            Text("Note: \(txn.note)")
                                .font(.subheadline)
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
        return TransactionListView()
    }
}
