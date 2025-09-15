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

                        Text("Debit")
                            .font(.custom("SFPro-Bold", size: 35))
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
                                .font(.custom("SFPro-Bold", size: 22))
                                .padding(.leading)

                            Menu {
                                ForEach(categories, id: \.self) { category in
                                    Button(action: {
                                        selectedCategory = category
                                    }) {
                                        HStack {
                                            Image(systemName: iconForCashOutCategory(category))
                                                .foregroundColor(colorForCashOutCategory(category))
                                            Text(category)
                                                .font(.custom("SFPro-Bold", size: 22))
                                        }
                                    }
                                }
                            } label: {
                                HStack {
                                    Image(systemName: iconForCashOutCategory(selectedCategory))
                                        .foregroundColor(colorForCashOutCategory(selectedCategory))
                                    Text(selectedCategory)
                                        .foregroundColor(.gray)
                                        .font(.custom("SFPro-Bold", size: 22))
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
                                .font(.custom("SFPro-Bold", size: 22))
                                .padding(.leading)

                            HStack {
                                Image(systemName: "creditcard.fill")
                                    .foregroundColor(.orange)
                                TextField("Enter Amount", text: $amount)
                                    .keyboardType(.decimalPad)
                                    .font(.custom("SFPro-Bold", size: 22))
                            }
                            .padding()
                            .frame(maxWidth: maxWidth)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(20)
                        }

                        // Date Picker
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Date")
                                .font(.custom("SFPro-Bold", size: 22))
                                .padding(.leading)

                            HStack {
                                Image(systemName: "calendar")
                                    .foregroundColor(.blue)
                                DatePicker("", selection: $date, displayedComponents: .date)
                                    .labelsHidden()
                                    .font(.custom("SFPro-Bold", size: 22))
                            }
                            .padding()
                            .frame(maxWidth: maxWidth)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(20)
                        }

                        // Note
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Note (optional)")
                                .font(.custom("SFPro-Bold", size: 22))
                                .padding(.leading)

                            HStack(alignment: .top) {
                                Image(systemName: "note.text")
                                    .foregroundColor(.purple)
                                    .padding(.top, 8)

                                TextEditor(text: $note)
                                    .frame(height: 80)
                                    .font(.custom("SFPro-Bold", size: 22))
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
                            alertMessage = "Debited sucessfully 😢"
                            showAlert = true
                        }) {
                            Text("Add")
                                .foregroundColor(.white)
                                .font(.custom("SFPro-Bold", size: 22))
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
                title: Text("Alert")
                    .font(.custom("SFPro-Bold", size: 22)),
                message: Text(alertMessage)
                    .font(.custom("SFPro-Bold", size: 22)),
                dismissButton: .default(Text("OK")
                    .font(.custom("SFPro-Bold", size: 22)))
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

// MARK: - Icon Mapper
func iconForCashOutCategory(_ category: String) -> String {
    switch category {
    case "Food": return "fork.knife"
    case "Travel": return "car.fill"
    case "Bills": return "doc.text.fill"
    case "Others": return "square.grid.2x2"
    case "Select Category": return "tag"
    default: return "circle"
    }
}

// MARK: - Color Mapper
func colorForCashOutCategory(_ category: String) -> Color {
    switch category {
    case "Food": return .orange
    case "Travel": return .blue
    case "Bills": return .purple
    case "Others": return .gray
    case "Select Category": return .black
    default: return .black
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
