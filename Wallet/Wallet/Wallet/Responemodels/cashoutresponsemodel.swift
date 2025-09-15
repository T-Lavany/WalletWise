import Foundation

// MARK: - Welcome
struct cashoutresponsemodel: Codable {
    let status: Bool
    let message: String
    let data: [cashoutresponsedata]
}

// MARK: - Datum
struct cashoutresponsedata: Codable {
    let email, type, category, date: String
    let note, amount: String
}
