//
//  DetailViewModel.swift
//  UserPostApp
//
//  Created by Yağmur Polat on 9.04.2022.
//

import Foundation

protocol DetailViewModelProtocol {
    // To get its own detail
    func getPostId() -> Int?
}

final class DetailViewModel {
    
    public var post: Post
    
    init(post: Post) {
        self.post = post
    }
}

extension DetailViewModel: DetailViewModelProtocol {
    
    func getPostId() -> Int? {
        
        return post.id
    }
}
