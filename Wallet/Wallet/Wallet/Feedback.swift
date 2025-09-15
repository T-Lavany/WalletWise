import SwiftUI

// Model for Feedback
struct Feedback: Identifiable {
    let id = UUID()
    let username: String
    let feedbackText: String
    let date: Date
}

// Admin Dashboard View
struct adminDashboardView: View {
    @State private var feedbacks: [Feedback] = []
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
            // Top bar with red background
            ZStack {
                Color.red.opacity(0.7)
                    .ignoresSafeArea(edges: .top)

                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding()
                    }

                    Spacer()

                    Text("Admin Dashboard")
                        .font(.system(size: 24, weight: .bold, design: .serif))
                        .foregroundColor(.white)
                        .padding()

                    Spacer()
                    
                    Spacer().frame(width: 44)
                }
                .padding(.top, 10)
            }
            .frame(height: 80)

            // Feedback List
            if feedbacks.isEmpty {
                Text("No feedbacks yet.")
                    .foregroundColor(.gray)
                    .padding(.top, 50)
            } else {
                List(feedbacks) { feedback in
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Username: \(feedback.username)")
                            .font(.headline)
                            .fontWeight(.bold)

                        Text("Feedback: \(feedback.feedbackText)")
                            .font(.body)
                            .foregroundColor(.gray)

                        Text("Date: \(formattedDate(feedback.date))")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                    .padding(.vertical, 8)
                }
                .listStyle(InsetGroupedListStyle())
            }

            // Logout Button
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Logout")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(20)
            }
            .padding()
        }
        .onAppear {
            loadFeedbackData()
        }
        .background(Color.white)
        .navigationBarHidden(true)
    }

    func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }

    func loadFeedbackData() {
        // Simulated feedbacks – replace with real data source
        feedbacks = [
            Feedback(username: "user1", feedbackText: "Amazing app experience!", date: Date()),
            Feedback(username: "user2", feedbackText: "Could use some improvements.", date: Date().addingTimeInterval(-86400)),
            Feedback(username: "user3", feedbackText: "Love the UI and stats.", date: Date().addingTimeInterval(-172800))
        ]
    }
}
struct adminDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AdminDashboardView()
        }
    }
}
//
//  Feedback.swift
//  Wallet
//
//  Created by SAIL on 29/05/25.
//

