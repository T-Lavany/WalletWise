import Foundation

// MARK: - Welcome
struct budgetgoalsresponsemodel: Codable {
    let status: Bool
    let message: String
    let data: budgetgoalsresponsedata
}

// MARK: - DataClass
struct budgetgoalsresponsedata: Codable {
    let email: String
    let income, savings, house, food: Int
    let lifestyle, entertainment, others: Int
}
//
//  budgetgoalsresponsemodel.swift
//  Wallet
//
//  Created by SAIL on 31/05/25.
//

