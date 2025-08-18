// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct loginresponsemodel: Codable {
    let status: Bool
    let message: String
    let data: [ResponseData]
}

// MARK: - Datum
struct ResponseData: Codable {
    let id: Int
    let name, email: String
}
//
//  loginresponsemodel.swift
//  Wallet
//
//  Created by SAIL on 29/05/25.
//

struct registerresponsemodel: Codable {
    let status: Bool
    let message: String
    let data: [registerResponseData]
}

// MARK: - Datum
struct registerResponseData: Codable {
    let  name, email, password: String
}
