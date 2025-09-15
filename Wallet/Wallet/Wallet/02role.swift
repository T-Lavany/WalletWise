import SwiftUI

struct RoleSelectionView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.pink.opacity(0.3)
                    .ignoresSafeArea()

                VStack {
                    Spacer()

                    Text("Welcome to")
                        .font(.custom("SF Pro", size: 50).weight(.bold))
                        .foregroundColor(.white)
                        .padding(.top, -50)

                    Text("WalletWise")
                        .font(.custom("SF Pro", size: 45).weight(.bold))
                        .foregroundColor(.white)
                        .padding(.bottom, 10)

                    HStack {
                        Circle().frame(width: 8, height: 8).foregroundColor(.white)
                        Rectangle().frame(height: 2).foregroundColor(.white)
                        Circle().frame(width: 8, height: 8).foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    .padding(.top, 4)

                    Text("Choose your role to proceed")
                        .font(.custom("SF Pro", size: 24).weight(.bold))
                        .foregroundColor(.white)
                        .padding(.top, 8)

                    Spacer()

                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 180)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .padding()

                    Spacer()

                    VStack(spacing: 15) {
                        NavigationLink(destination: AdminLoginView()) {
                            HStack {
                                Text("Admin")
                                    .font(.custom("SF Pro", size: 28).weight(.bold))
                                Spacer()
                                Image(systemName: "person.crop.rectangle")
                                    .font(.system(size: 28, weight: .bold))
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(.systemGray6))
                            .foregroundColor(.black)
                            .clipShape(Capsule())
                            .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 4)
                        }

                        NavigationLink(destination: EnterPageView()) {
                            HStack {
                                Text("User")
                                    .font(.custom("SF Pro", size: 28).weight(.bold))
                                Spacer()
                                Image(systemName: "person")
                                    .font(.system(size: 28, weight: .bold))
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(.systemGray6))
                            .foregroundColor(.black)
                            .clipShape(Capsule())
                            .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 4)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                }
                .padding(.horizontal)
            }
        }
    }
}

struct RoleSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        RoleSelectionView()
    }
}
