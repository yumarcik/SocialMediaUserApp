//
//  Comment.swift
//  UserPostApp
//
//  Created by Yağmur Polat on 5.04.2022.
//

import Foundation

public struct Comment: Decodable {
    let postId, id: Int?
    let name, email, body: String?
}
