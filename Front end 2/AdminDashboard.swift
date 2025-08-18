import SwiftUI



struct AdminDashboardView: View {
    @State private var feedbacks = [FeedBackDatum]()   // ✅ make it @State so it updates

    var body: some View {
        NavigationView {
            List(feedbacks, id: \.id) { feedback in     // ✅ works fine without Identifiable
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text("User: \(feedback.email.rawValue)") // ✅ email is enum, use rawValue
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("⭐️ \(feedback.starRating)/5")      // ✅ property is starRating
                            .font(.subheadline)
                            .foregroundColor(.orange)
                    }

                    Text(feedback.feedback)                      // ✅ property is feedback
                        .font(.body)
                    Text(formatDate(feedback.submittedAt))        // ✅ format submittedAt
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Admin Dashboard")
            .onAppear {
                fetchFeedbacks()
            }
        }
    }

    // ✅ API Call
    func fetchFeedbacks() {
        APIHandler.shared.getAPIValues(
            type: FeedBack.self,
            apiUrl: APIList.feedback,
            method: "GET"
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print("Fetch successful:", response)
                    feedbacks = response.data
                case .failure(let error):
                    print("Fetch failed:", error)
                }
            }
        }
    }

    // ✅ Date formatter
    func formatDate(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            return date.formatted(date: .abbreviated, time: .shortened)
        }
        return dateString
    }
}

struct AdminDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        AdminDashboardView()
    }
}

// MARK: - Models
struct FeedBack: Codable {
    let status, message: String
    let data: [FeedBackDatum]
}

struct FeedBackDatum: Codable {
    let id: Int
    let email: Email
    let starRating: Int
    let feedback: String
    let submittedAt: String

    enum CodingKeys: String, CodingKey {
        case id, email
        case starRating = "star_rating"
        case feedback
        case submittedAt = "submitted_at"
    }
}

enum Email: String, Codable {
    case hariniGamailCOM = "harini@gamail.com"
    case lavGmailCOM = "lav@gmail.com"
    case the1GamailCOM = "1@gamail.com"
    case the1GmailCOM = "1@gmail.com"
}
