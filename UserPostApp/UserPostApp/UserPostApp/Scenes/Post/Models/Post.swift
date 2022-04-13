//
//  Post.swift
//  UserPostApp
//
//  Created by Yağmur Polat on 5.04.2022.
//

import Foundation

public struct Post: Decodable {
    let userId, id: Int?
    let title, body: String?
}
