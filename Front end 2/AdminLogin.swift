import SwiftUI

struct AdminLoginView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loginStatus: String = ""
    @State private var isLoggedIn: Bool = false

    // Hardcoded valid admin credentials
    private let validEmail = "admin"
    private let validPassword = "admin123"

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    // Top bar
                    ZStack {
                        Color.green
                            .ignoresSafeArea(edges: .top)

                        HStack {
                            Button(action: {
                                dismiss()
                            }) {
                                Image(systemName: "")
                                    .font(.title2)
                                    .foregroundColor(.black)
                                    .padding()
                            }

                            Spacer()

                            Text("Admin Login")
                                .font(.system(size: 30, weight: .semibold, design: .serif))
                                .padding()

                            Spacer()
                            Spacer().frame(width: 44)
                        }
                        .padding(.top, 10)
                    }
                    .frame(height: 80)

                    ScrollView {
                        VStack(spacing: 30) {
                            let maxWidth = min(geometry.size.width * 0.9, 600)

                            // Email Field
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Email")
                                    .font(.headline)
                                    .bold()
                                    .padding(.leading)

                                TextField("Enter Email", text: $email)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                                    .padding(.horizontal, 30)
                            }

                            // Password Field
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Password")
                                    .font(.headline)
                                    .bold()
                                    .padding(.leading)

                                SecureField("Enter Password", text: $password)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .padding(.horizontal, 30)
                            }

                            // Login Button
                            Button(action: {
                                if email == validEmail && password == validPassword {
                                    loginStatus = "Successfully Logged In"
                                    isLoggedIn = true
                                } else {
                                    loginStatus = "Invalid Credentials"
                                    isLoggedIn = false
                                }
                            }) {
                                Text("Login")
                                    .font(.system(size: 18, weight: .medium, design: .serif))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.green)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 30)
                            }

                            // Login status
                            Text(loginStatus)
                                .font(.system(size: 18, design: .serif))
                                .foregroundColor(isLoggedIn ? .green : .red)
                                .padding()

                            // NavigationLink to AdminDashboardView
                            NavigationLink(destination: AdminDashboardView(), isActive: $isLoggedIn) {
                                EmptyView()
                            }
                        }
                        .padding(.top)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }
}

struct AdminLoginView_Previews: PreviewProvider {
    static var previews: some View {
        AdminLoginView()
    }
}
