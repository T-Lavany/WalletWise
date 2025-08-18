import SwiftUI

struct RateAppView: View {
    @State private var email:String=""
    @State private var star_rating: Int = 0
    @State private var feedback: String = ""
    @State private var isSending = false
    @State private var alertMessage: String?
    @State private var showAlert = false

    var body: some View {
        VStack(spacing: 40) {
            // Header
            HStack {
                Button(action: {
                    // Add back action here if needed
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }

                Spacer()

                Text("Rate App")
                    .font(.system(size: 24, weight: .medium, design: .serif))
                    .italic()

                Spacer()
            }
            .padding()
            .background(Color.green)

            // Feedback Prompt
            VStack(spacing: 20) {
                Text("How was the experience?\nPlease provide Feedback")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 30, design: .serif))
                    .foregroundColor(.black)
            }

            // Rating TextField Input
            VStack(alignment: .leading, spacing: 8) {
                Text("Rating (1 to 5)")
                    .font(.system(size: 18, design: .serif))
                    .foregroundColor(.gray)

                TextField("Enter your rating", value: $star_rating, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .padding(.horizontal, 30)
                    .onChange(of: star_rating) { newValue in
                        if newValue < 0 {
                            star_rating = 0
                        } else if newValue > 5 {
                            star_rating = 5
                        }
                    }
            }

            // Comment TextEditor
            VStack(alignment: .leading) {
                Text("Your Comments")
                    .font(.system(size: 18, design: .serif))
                    .foregroundColor(.gray)

                TextEditor(text: $feedback)
                    .frame(height: 100)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                    .padding(.horizontal, 30)
            }

            // Send Feedback Button
            Button(action: {
                if star_rating == 0 {
                    alertMessage = "Please provide a rating."
                    showAlert = true
                    return
                }
                sendFeedbackApiCall(email:email,rating: star_rating, comment: feedback)
            }) {
                if isSending {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green.opacity(0.7))
                        .cornerRadius(40)
                        .padding(.horizontal, 30)
                } else {
                    Text("Send Feedback")
                        .font(.system(size: 20, design: .serif))
                        .italic()
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(40)
                        .padding(.horizontal, 30)
                }
            }
            .disabled(isSending)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Feedback"), message: Text(alertMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
            }

            Spacer()
        }
        .padding(.top, 40)
        .background(Color.white)
        .edgesIgnoringSafeArea(.top)
    }

    func sendFeedbackApiCall(email:String,rating: Int, comment: String) {
        isSending = true

        let param = [
            "email":Datamanager.shared.email,
            "star_rating": String(rating),
            "feedback": comment
        ]

        APIHandler.shared.postAPIValues(
            type: reviewresponsemodel.self,
            apiUrl: APIList.ratingUrl,  // Replace with your feedback API URL
            method: "POST",
            formData: param
        ) { result in
            DispatchQueue.main.async {
                isSending = false
                switch result {
                case .success(let response):
                    alertMessage = response.message
                    showAlert = true
                    self.star_rating = 0
                    self.feedback = ""
                case .failure(let error):
                    alertMessage = "Somethig went wrong!"
                    showAlert = true
                }
            }
        }
    }
}

struct RateAppView_Previews: PreviewProvider {
    static var previews: some View {
        RateAppView()
    }
}
