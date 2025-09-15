import SwiftUI

struct CashInView: View {
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
                    
                    // Top Bar with Back to Home
                    HStack {
                        NavigationLink(destination: DashboardView()) {
                            HStack {
                                Image(systemName: "chevron.left")
                                    .font(.title2)
                                Text("Home")
                                    .font(.headline)
                            }
                            .foregroundColor(.blue)
                            .padding()
                        }
                        Spacer()
                        Text("Credit")
                            .font(.custom("SF Pro", size: 40).bold())
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
                                .font(.custom("SF Pro", size: 22).bold())
                                .padding(.leading)
                            Menu {
                                ForEach(categories, id: \.self) { category in
                                    Button(action: {
                                        selectedCategory = category
                                    }) {
                                        HStack {
                                            Image(systemName: iconForCategory(category))
                                                .foregroundColor(colorForCategory(category))
                                            Text(category)
                                                .font(.custom("SF Pro", size: 22).bold())
                                        }
                                    }
                                }
                            } label: {
                                HStack {
                                    Image(systemName: iconForCategory(selectedCategory))
                                        .foregroundColor(colorForCategory(selectedCategory))
                                    Text(selectedCategory)
                                        .foregroundColor(.gray)
                                        .font(.custom("SF Pro", size: 22).bold())
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
                                .font(.custom("SF Pro", size: 22).bold())
                                .padding(.leading)
                            HStack {
                                Image(systemName: "wallet.pass")
                                    .foregroundColor(.orange)
                                TextField("Enter Amount", text: $amount)
                                    .keyboardType(.decimalPad)
                                    .font(.custom("SF Pro", size: 22).bold())
                            }
                            .padding()
                            .frame(maxWidth: maxWidth)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(20)
                        }
                        
                        // Date
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Date")
                                .font(.custom("SF Pro", size: 22).bold())
                                .padding(.leading)
                            HStack {
                                Image(systemName: "calendar")
                                    .foregroundColor(.blue)
                                DatePicker("", selection: $date, displayedComponents: .date)
                                    .labelsHidden()
                                    .font(.custom("SF Pro", size: 22).bold())
                            }
                            .padding()
                            .frame(maxWidth: maxWidth)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(20)
                        }
                        
                        // Note
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Note (optional)")
                                .font(.custom("SF Pro", size: 22).bold())
                                .padding(.leading)
                            HStack(alignment: .top) {
                                Image(systemName: "note.text")
                                    .foregroundColor(.purple)
                                    .padding(.top, 8)
                                TextEditor(text: $note)
                                    .frame(height: 80)
                                    .font(.custom("SF Pro", size: 22).bold())
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
                            alertMessage = "Amount credited successfully!"
                            showAlert = true
                        }) {
                            Text("Add")
                                .foregroundColor(.white)
                                .font(.custom("SF Pro", size: 22).bold())
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
        // 👇 Hide system back button, only keep custom back-to-home
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Success").font(.custom("SF Pro", size: 18).bold()),
                message: Text(alertMessage).font(.custom("SF Pro", size: 16).bold()),
                dismissButton: .default(Text("OK").font(.custom("SF Pro", size: 16).bold()))
            )
        }
        .onAppear {
            print("Email from AppStorage in CashInView: \(email)")
        }
    }

    func cashinApiCall(email: String, category: String, amount: String, date: String, note: String) {
        let param = [
            "email": Datamanager.shared.email,
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

// MARK: - Icon Mapper
func iconForCategory(_ category: String) -> String {
    switch category {
    case "Salary": return "banknote"
    case "Business": return "briefcase"
    case "Loan": return "creditcard"
    case "Others": return "square.grid.2x2"
    case "Select Category": return "tag"
    default: return "circle"
    }
}

// MARK: - Color Mapper
func colorForCategory(_ category: String) -> Color {
    switch category {
    case "Salary": return .green
    case "Business": return .blue
    case "Loan": return .red
    case "Others": return .gray
    case "Select Category": return .black
    default: return .black
    }
}

struct CashInView_preview: PreviewProvider {
    static var previews: some View {
       NavigationView {
           CashInView()
       }
   }
}

