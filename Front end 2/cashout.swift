import SwiftUI

struct CashOutView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var email: String = ""
    @State private var selectedCategory: String = "Select Category"
    @State private var amount: String = ""
    @State private var date = Date()
    @State private var note: String = ""

    @State private var showAlert = false
    @State private var alertMessage = ""

    let categories = ["Others", "Food", "Travel", "Bills"]

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Top bar with red background
                ZStack {
                    Color.red.opacity(0.7)
                        .ignoresSafeArea(edges: .top)

                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "")
                                .font(.title2)
                                .foregroundColor(.black)
                                .padding()
                        }

                        Spacer()

                        Text("CashOut")
                            .font(.system(size: 30, weight: .semibold, design: .serif))
                            .padding()

                        Spacer()

                        Spacer().frame(width: 44) // Symmetric space
                    }
                    .padding(.top, 10)
                }
                .frame(height: 80)

                // ScrollView content
                ScrollView {
                    VStack(spacing: 30) {
                        let maxWidth = min(geometry.size.width * 0.9, 600)

                        // Category Picker
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Category")
                                .font(.headline)
                                .bold()
                                .padding(.leading)

                            Menu {
                                ForEach(categories, id: \.self) { category in
                                    Button(action: {
                                        selectedCategory = category
                                    }) {
                                        Text(category).bold()
                                    }
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "square.grid.2x2")
                                    Text(selectedCategory)
                                        .foregroundColor(.gray)
                                        .bold()
                                    Spacer()
                                }
                                .padding()
                                .frame(maxWidth: maxWidth)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(20)
                            }
                        }

                        // Amount
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Amount")
                                .font(.headline)
                                .bold()
                                .padding(.leading)

                            HStack {
                                Image(systemName: "creditcard.fill")
                                TextField("Enter Amount", text: $amount)
                                    .keyboardType(.decimalPad)
                                    .fontWeight(.bold)
                            }
                            .padding()
                            .frame(maxWidth: maxWidth)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(20)
                        }

                        // Date Picker
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Date")
                                .font(.headline)
                                .bold()
                                .padding(.leading)

                            HStack {
                                Image(systemName: "calendar")
                                DatePicker("", selection: $date, displayedComponents: .date)
                                    .labelsHidden()
                                    .fontWeight(.bold)
                            }
                            .padding()
                            .frame(maxWidth: maxWidth)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(20)
                        }

                        // Note
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Note (optional)")
                                .font(.headline)
                                .bold()
                                .padding(.leading)

                            HStack(alignment: .top) {
                                Image(systemName: "note.text")
                                    .padding(.top, 8)

                                TextEditor(text: $note)
                                    .frame(height: 80)
                                    .font(.body)
                                    .cornerRadius(10)
                                    .padding(.vertical, 8)
                            }
                            .padding()
                            .frame(maxWidth: maxWidth)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(20)
                        }

                        // Add Button
                        Button(action: {
                            // Format the date to "yyyy-MM-dd"
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            let dateString = dateFormatter.string(from: date)

                            // Call API
                            cashoutApiCall(
                                email: email.isEmpty ? Datamanager.shared.email : email,
                                category: selectedCategory,
                                amount: amount,
                                date: dateString,
                                note: note
                            )

                            // Show Alert
                            alertMessage = "Cash Out added 😢"
                            showAlert = true
                        }) {
                            Text("Add")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.title2)
                                .padding()
                                .frame(maxWidth: maxWidth)
                                .background(Color.red)
                                .cornerRadius(20)
                                .padding(.top, 50)
                        }

                        Spacer()
                    }
                    .padding(.top)
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Alert"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

func cashoutApiCall(email: String, category: String, amount: String, date: String, note: String) {
    let param = [
        "email": Datamanager.shared.email,
        "category": category,
        "amount": amount,
        "date": date,
        "note": note
    ]
    
    APIHandler.shared.postAPIValues(
        type: cashoutresponsemodel.self,
        apiUrl: APIList.cashoutUrl,
        method: "POST",
        formData: param
    ) { result in
        DispatchQueue.main.async {
            switch result {
            case .success(let response):
                print("Cashout API Success:", response)
            case .failure(let error):
                print("Cashout API Error:", error)
            }
        }
    }
}

struct CashOutView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CashOutView()
                .previewDevice("iPhone 14")
            CashOutView()
                .previewDevice("iPad Pro (12.9-inch) (6th generation)")
        }
    }
}
