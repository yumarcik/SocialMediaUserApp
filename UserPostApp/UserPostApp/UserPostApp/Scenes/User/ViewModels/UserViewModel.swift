//
//  HomePageViewModel.swift
//  UserPostApp
//
//  Created by Yağmur Polat on 6.04.2022.
//

import Foundation


protocol UserViewModelProtocol {
    
    var delegate: UserViewModelDelegate? { get set }
    var numberOfRowsInSection: Int { get }
    var cellHeight: Double { get }
    var cellBorderWidth: Double { get }
    var cellCornerRadius: Double { get }
    func user(index: Int) -> User?
    func load()
    func getUserId(index: Int) -> Int?
    func getUserName(index: Int) -> String?
}

protocol UserViewModelDelegate: AnyObject {
    
    func reloadData()
}

final class UserViewModel {
    
    private var users = [User]()
    
    let service: NetworkServiceProtocol
    weak var delegate: UserViewModelDelegate?
    
    
    init(service: NetworkServiceProtocol) {
        self.service = service
    }
    
    fileprivate func getUsers() {
        
        service.getUsers { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let users):
                self.users = users
                self.delegate?.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}

extension UserViewModel: UserViewModelProtocol {
    
    var cellBorderWidth: Double {
        return 0.8
    }
    
    var cellCornerRadius: Double {
        return 10
    }
    
    func getUserName(index: Int) -> String? {
        return users[index].name
    }
    
    var cellHeight: Double {
        return 70
    }
    
    
    func getUserId(index: Int) -> Int? {
        return users[index].id
    }
    
    var numberOfRowsInSection: Int {
        users.count
    }
    
    func user(index: Int) -> User? {
        users[index]
    }
    
    func load() {
        getUsers()
    }
    
}
