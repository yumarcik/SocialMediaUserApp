//
//  UserModel.swift
//  UserPostApp
//
//  Created by Yağmur Polat on 4.04.2022.
//

import Foundation

public struct User: Decodable {
    let id: Int?
    let name, username: String?
    let address: Address?
    let company: Company?
}

public struct Address: Decodable {
    let city: String?
}

public struct Company: Decodable {
    let name: String?
}
