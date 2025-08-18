import SwiftUI

struct EnterPageView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn = false  // To trigger navigation

    var body: some View {
      
            VStack(spacing: 20) {
                Spacer()

                Text("Welcome Back!")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.black)

                Text("Login to continue")
                    .font(.title3)
                    .foregroundColor(.black)

                Image("Logo1") // Replace with your actual asset name
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
                        .font(.custom("Georgia-Italic", size: 30))

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                        .padding(.horizontal)
                        .font(.custom("Georgia-Italic", size: 30))
                }
                .padding()

                Button(action: {
                    
                    if email != "" && password != "" {
                        loginApiCall(email: email, password: password)
                    }else {
                        AlertManager.shared.show(message: "Fill all the fields")
                    }
                       
                    
                   
                }) {
                    Text("Login")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .clipShape(Capsule())
                        .padding(.horizontal)
                }
                .disabled(email.isEmpty || password.isEmpty)
                .withGlobalAlert()

                HStack {
                    Text("Don't Have an Account?")
                        .font(.system(size: 18))
                        .foregroundColor(.black)

                    NavigationLink(destination: RegisterView()) {
                        Text("Create")
                            .font(.system(size: 18, weight: .bold))
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
