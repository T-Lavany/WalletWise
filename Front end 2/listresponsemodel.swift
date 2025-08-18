import Foundation

// MARK: - Welcome
struct listresponsemodel: Codable {
    let status: Bool
    let message: String
    let data: [listresponsedata]
}

// MARK: - Datum
struct listresponsedata: Codable {
    let id: Int
    let date, category, amount, note: String
}
