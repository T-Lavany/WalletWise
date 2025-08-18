import SwiftUI

struct enterpage: View {
    var body: some View {
       
            ZStack {
                Color.green
                    .ignoresSafeArea() // Ensures full background coverage

                VStack(spacing: 30) {
                    Spacer()

                    Text("Welcome to")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)

                    Text("Expense Tracker")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                        .italic()

                    Divider()
                        .frame(height: 2)
                        .background(Color.white)
                        .padding(.horizontal)

                    Text("Manage Your Daily Expenses")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)

                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .background(Color.white)
                        .cornerRadius(40)
                        .padding()

                    Spacer()

                    VStack(spacing: 20) {
                        NavigationLink(destination: RoleSelectionView()) {
                            Text("Login")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.black)
                                .cornerRadius(40)
                        }

                        NavigationLink(destination: RegisterView()) {
                            Text("Register")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.black)
                                .cornerRadius(40)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                }
            }
        
    }
}

struct enterpage_preview: PreviewProvider {
    static var previews: some View {
        EnterPageView()
    }
}
