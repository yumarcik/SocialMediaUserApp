//
//  PostViewModel.swift
//  UserPostApp
//
//  Created by Yağmur Polat on 7.04.2022.
//

import Foundation

protocol PostViewModelProtocol {
    
    var delegate: PostViewModelDelegate? { get set }
    var numberOfRowsInSection: Int { get }
    var cellHeight: Double { get }
    var cellBorderWidth: Double { get }
    var cellCornerRadius: Double { get }
    var heightForHeader: Double { get }
    func post(index: Int) -> Post?
    func load()

}

protocol PostViewModelDelegate: AnyObject {
    
    func reloadData()
}

final class PostViewModel {
    
    private var posts = [Post]()
    
    let service: NetworkServiceProtocol
    private let userId: Int
    weak var delegate: PostViewModelDelegate?
    
    init(userId: Int, service: NetworkServiceProtocol) {
        self.service = service
        self.userId = userId
    }
    
    // Using custom URL path with userId
    fileprivate func getPosts() {
        service.getPosts(userId: userId) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let posts):
                self.posts = posts
                self.delegate?.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension PostViewModel: PostViewModelProtocol {
    
    var heightForHeader: Double {
        return 2
    }
    
    var cellBorderWidth: Double {
        return 1
    }
    
    var cellCornerRadius: Double {
        return 2
    }
    
    var cellHeight: Double {
        return 50
    }
    
    var numberOfRowsInSection: Int {
        posts.count
    }
    
    func post(index: Int) -> Post? {
        posts[index]
    }
    
    func load() {
        getPosts()
    }
    
}
