import SwiftUI

struct CustomInputField: View {
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .font(.custom("SF Pro", size: 18).weight(.bold))
            } else {
                TextField(placeholder, text: $text)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .font(.custom("SF Pro", size: 18).weight(.bold))
            }
        }
        .padding(.horizontal)
    }
}

struct RegisterView: View {
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showHome = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            // Title
            Text("Register")
                .font(.custom("SF Pro", size: 50).weight(.bold))
                .foregroundColor(.black)
                .padding(.top, -100)

            // Subtitle
            Text("If you don’t have an account")
                .font(.custom("SF Pro", size: 28).weight(.bold))
                .foregroundColor(.black)

            // Input Fields
            VStack(spacing: 20) {
                CustomInputField(placeholder: "Full Name", text: $fullName)
                CustomInputField(placeholder: "Email", text: $email)
                CustomInputField(placeholder: "Password", text: $password, isSecure: true)
                CustomInputField(placeholder: "Re-enter Password", text: $confirmPassword, isSecure: true)
            }
            .padding(.horizontal)

            // Register Button
            Button(action: {
                if password != confirmPassword {
                    alertMessage = "Passwords do not match!"
                    showAlert = true
                    return
                }
                registerApiCall(name: fullName, email: email, password: password) { success in
                    if success {
                        showHome = true
                    } else {
                        alertMessage = "Registration failed. Please try again."
                        showAlert = true
                    }
                }
            }) {
                Text("Register")
                    .font(.custom("SF Pro", size: 28).weight(.bold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.8))
                    .clipShape(Capsule())
            }
            .padding(.horizontal)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }

            // Navigation trigger to DashboardView
            NavigationLink(
                destination: DashboardView()
                    .navigationBarBackButtonHidden(true), // Hide back button on DashboardView
                isActive: $showHome
            ) {
                EmptyView()
            }

            Spacer()

            // Already a user? Login link
            HStack {
                Text("Already a user?")
                    .font(.custom("SF Pro", size: 22).weight(.bold))
                    .foregroundColor(.black)

                NavigationLink(destination: EnterPageView()) {
                    Text("Login")
                        .font(.custom("SF Pro", size: 20).weight(.bold))
                        .foregroundColor(.red)
                        .underline()
                }
            }
            .padding(.bottom, 20)
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

// Your existing register API call function
func registerApiCall(name: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
    let param = ["name": name, "email": email, "password": password]

    APIHandler.shared.postAPIValues(
        type: registerresponsemodel.self,
        apiUrl: APIList.registerUrl,
        method: "POST",
        formData: param
    ) { result in
        DispatchQueue.main.async {
            switch result {
            case .success(let response):
             // success
                
                if response.status {
                    print("Register successful:", response)
                    Datamanager.shared.email = email
                    completion(true)
                }else {
                    print(response.message)
                    completion(false)
                }

            case .failure(let error):
                print("Register failed:", error)

                // If error is decoding error, optionally treat as success
                if case DecodingError.typeMismatch = error {
                    print("Decoding error ignored, treat as success")
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
