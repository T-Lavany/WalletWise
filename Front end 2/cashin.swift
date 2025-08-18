import SwiftUI

struct CashInView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("email") private var email: String = ""
    @State private var selectedCategory: String = "Select Category"
    @State private var amount: String = ""
    @State private var date = Date()
    @State private var note: String = ""

    @State private var showAlert = false
    @State private var alertMessage = ""

    let categories = ["Others", "Salary", "Business", "Loan"]

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 30) {
                    
                    // Top Bar
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
                        Text("CashIn")
                            .font(.system(size: 30, weight: .semibold, design: .serif))
                            .padding(.top, 70)
                        Spacer()
                        Spacer().frame(width: 50)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.green.opacity(1))
                    .padding(.top, -80)
                    
                    let maxWidth = min(geometry.size.width * 0.9, 600)
                    
                    Group {
                        // Category
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
                                Image(systemName: "wallet.pass")
                                TextField("Enter Amount", text: $amount)
                                    .keyboardType(.decimalPad)
                                    .fontWeight(.bold)
                            }
                            .padding()
                            .frame(maxWidth: maxWidth)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(20)
                        }
                        
                        // Date
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
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            let formattedDate = dateFormatter.string(from: date)

                            cashinApiCall(email: email, category: selectedCategory, amount: amount, date: formattedDate, note: note)

                            // Trigger alert
                            alertMessage = "Cash In added successfully!"
                            showAlert = true
                        }) {
                            Text("Add")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.title2)
                                .padding()
                                .frame(maxWidth: maxWidth)
                                .background(Color.green)
                                .cornerRadius(20)
                                .padding(.top, 50)
                        }
                    }

                    Spacer()
                }
                .padding(.top)
                .frame(maxWidth: .infinity)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Success"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .onAppear {
            print("Email from AppStorage in CashInView: \(email)")
        }
    }

    func cashinApiCall(email: String, category: String, amount: String, date: String, note: String) {
        let param = [
            "email": Datamanager.shared.email,  // Use parameter, not Datamanager.shared.email
            "category": category,
            "amount": amount,
            "date": date,
            "note": note
        ]
        
        APIHandler.shared.postAPIValues(
            type: cashinresponsemodel.self,
            apiUrl: APIList.cashinUrl,
            method: "POST",
            formData: param
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print("CashIn API Success:", response)
                case .failure(let error):
                    print("CashIn API Error:", error)
                }
            }
        }
    }
}

struct CashInView_preview: PreviewProvider {
    static var previews: some View {
       CashInView()
   }
}
