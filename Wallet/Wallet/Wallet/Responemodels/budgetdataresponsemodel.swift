import Foundation

// MARK: - Welcome
struct budgetdataresponsemodel: Codable {
    let status: Bool
    let message: String
    let data: budgetdataresponsedata
}

// MARK: - DataClass
struct budgetdataresponsedata: Codable {
    let email: String
    let income, savings, budget: Int
    let allocations: Allocations
}

// MARK: - Allocations
struct Allocations: Codable {
    let house, food, lifestyle, entertainment: Int
    let others: Int

    enum CodingKeys: String, CodingKey {
        case house = "House"
        case food = "Food"
        case lifestyle = "Lifestyle"
        case entertainment = "Entertainment"
        case others = "Others"
    }
}
//
//  budgetdataresponsemodel.swift
//  Wallet
//
//  Created by SAIL on 03/06/25.
//

