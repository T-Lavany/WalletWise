import Foundation

// MARK: - Welcome
struct cashinresponsemodel: Codable {
    let status: Bool
    let message: String
    let data: [cashinresponsedata]
}

// MARK: - Datum
struct cashinresponsedata: Codable {
    let email, type, category, date: String
    let note, amount: String
}



