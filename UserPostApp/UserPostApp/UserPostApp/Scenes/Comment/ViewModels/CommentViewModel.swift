//
//  CommentViewModel.swift
//  UserPostApp
//
//  Created by Yağmur Polat on 10.04.2022.
//

import Foundation

protocol CommentViewModelProtocol {
    
    var delegate: CommentViewModelDelegate? { get set }
    var numberOfRowsInSection: Int { get }
    var cellHeight: Double { get }
    var cellBorderWidth: Double { get }
    var cellCornerRadius: Double { get }
    var heightForHeader: Double { get }
    func comment(index: Int) -> Comment?
    func load()
}

protocol CommentViewModelDelegate: AnyObject {
    func reloadData()
}

final class CommentViewModel {
    
    private var comments = [Comment]()
    
    let service: NetworkServiceProtocol
    private let postId: Int
    weak var delegate: CommentViewModelDelegate?
    
    init(postId: Int, service: NetworkServiceProtocol) {
        self.postId = postId
        self.service = service
    }
    
    fileprivate func getComments() {
        service.getComments(postId: postId) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let comments):
                self.comments = comments
                self.delegate?.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension CommentViewModel: CommentViewModelProtocol {
    
    var heightForHeader: Double {
        return 0.2
    }
    
    var cellBorderWidth: Double {
        return 1
    }
    
    var cellCornerRadius: Double {
        return 2
    }
    
    var numberOfRowsInSection: Int {
        return comments.count
    }
    
    var cellHeight: Double {
        return 160
    }
    
    func comment(index: Int) -> Comment? {
        comments[index]
    }
    
    func load() {
        getComments()
    }
    
}
