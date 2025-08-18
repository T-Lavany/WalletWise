import Foundation

// MARK: - Welcome
struct reviewresponsemodel: Codable {
    let status, message: String
    let data: reviewresponsedata
}

// MARK: - DataClass
struct reviewresponsedata: Codable {
    let email: String
    let starRating: Int
    let feedback: String

    enum CodingKeys: String, CodingKey {
        case email
        case starRating = "star_rating"
        case feedback
    }
}
