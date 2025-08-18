import SwiftUI

struct DeleteAccountView: View {
    var body: some View {
        VStack(spacing: 0) {
            // Top Header
            HStack {
                Image(systemName: "")
                    .font(.title2)
                Spacer()
                Text("Delete Account")
                    .font(.title2)
                    .italic()
                Spacer()
                Spacer() // for alignment
            }
            .padding()
            .background(Color.green)
            .padding(.top,50)

            Spacer()

            // Confirmation Box
            VStack(spacing: 0) {
                VStack(spacing: 5) {
                    Text("Delete Account?")
                        .font(.title3)
                        .italic()
                    Text("Are you sure?")
                        .font(.title3)
                        .italic()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.3))

                HStack(spacing: 0) {
                    Button(action: {
                        print("Cancel tapped")
                    }) {
                        Text("Cancel")
                            .font(.title3)
                            .italic()
                            .frame(maxWidth: .infinity, maxHeight: 60)
                            .background(Color.gray.opacity(0.3))
                            .border(Color.black, width: 1)
                    }

                    Button(action: {
                        print("Sure tapped - Proceed with deletion")
                    }) {
                        Text("Sure")
                            .font(.title3)
                            .italic()
                            .frame(maxWidth: .infinity, maxHeight: 60)
                            .background(Color.gray.opacity(0.3))
                            .border(Color.black, width: 1)
                    }
                }
            }
            .border(Color.black, width: 1)
            .padding()

            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct DeleteAccountView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAccountView()
    }
}
//
//  DeletePage.swift
//  WalletWise
//
//  Created by SAIL on 06/05/25.
//

