import SwiftUI

struct EnterPageView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn = false  // To trigger navigation

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Text("Welcome Back!")
                .font(.custom("SF Pro", size: 45).weight(.bold))
                .foregroundColor(.black)

            Text("Login to continue")
                .font(.custom("SF Pro", size: 30).weight(.bold))
                .foregroundColor(.black)

            Image("Logo1")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)

            VStack(spacing: 16) {
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .foregroundColor(.black)
                    .clipShape(Capsule())
                    .padding(.horizontal)
                    .font(.custom("SF Pro", size: 28).weight(.bold))

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .foregroundColor(.black)
                    .clipShape(Capsule())
                    .padding(.horizontal)
                    .font(.custom("SF Pro", size: 28).weight(.bold))
            }
            .padding()

            Button(action: {
                if email != "" && password != "" {
                    loginApiCall(email: email, password: password)
                } else {
                    AlertManager.shared.show(message: "Fill all the fields")
                }
            }) {
                Text("Login")
                    .font(.custom("SF Pro", size: 28).weight(.bold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.8))
                    .clipShape(Capsule())
                    .padding(.horizontal)
            }
            .disabled(email.isEmpty || password.isEmpty)
            .withGlobalAlert()

            HStack {
                Text("Don't Have an Account?")
                    .font(.custom("SF Pro", size: 22).weight(.bold))
                    .foregroundColor(.black)

                NavigationLink(destination: RegisterView()) {
                    Text("Create")
                        .font(.custom("SF Pro", size: 18).weight(.bold))
                        .foregroundColor(.red)
                        .underline()
                }
            }
            .padding(.bottom, 20)

            Spacer()

            // Invisible NavigationLink triggered on successful login
            NavigationLink(destination: DashboardView(), isActive: $isLoggedIn) {
                EmptyView()
            }
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
    }

    func loginApiCall(email: String, password: String) {
        let param = ["email": email, "password": password]

        APIHandler.shared.postAPIValues(
            type: loginresponsemodel.self,
            apiUrl: APIList.loginUrl,
            method: "POST",
            formData: param
        ) { result in
            DispatchQueue.main.sync {
                switch result {
                case .success(let response):
                    print("Login successful:", response)
                    Datamanager.shared.email = email
                    isLoggedIn = true // Navigate to Dashboard
                case .failure(let error):
                    print("Login failed:", error)
                }
            }
        }
    }
}

struct EnterPageView_Previews: PreviewProvider {
    static var previews: some View {
        EnterPageView()
    }
}
