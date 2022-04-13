//
//  UserService.swift
//  UserPostApp
//
//  Created by Yağmur Polat on 5.04.2022.
//

import Foundation

public protocol NetworkServiceProtocol {
    func getUsers(completion: @escaping (Result<[User], UserPostError>) -> Void)
    func getPosts(userId: Int, completion: @escaping (Result<[Post], UserPostError>) -> Void)
    func getComments(postId: Int, completion: @escaping (Result<[Comment], UserPostError>) -> Void)
}
// Service Errors
public enum UserPostError: Error {
    case noDataAvailable
    case canNotProcessData
}

class NetworkService: NetworkServiceProtocol {
    
    private let mainPath: String = "https://jsonplaceholder.typicode.com"
    
    private var usersUrl: String {
        return mainPath + "/users"
    }
    
    private var postsUrl: String {
        return mainPath + "/posts?userId="
    }
    
    private var commentsUrl: String {
        return mainPath + "/comments?postId="
    }
    
    // Service Functions
    
    // MARK: User Service
    func getUsers(completion: @escaping (Result<[User], UserPostError>) -> Void) {
        
        guard let url = URL(string: usersUrl) else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let users = try decoder.decode([User].self, from: jsonData)
                completion(.success(users))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        
        dataTask.resume()
        
    }
    
    // MARK: Post Service
    func getPosts(userId: Int, completion: @escaping (Result<[Post], UserPostError>) -> Void) {
        
        guard let url = URL(string: postsUrl + String(userId)) else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let posts = try decoder.decode([Post].self, from: jsonData)
                completion(.success(posts))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        
        dataTask.resume()
        
    }
    
    // MARK: Comment Service
    func getComments(postId: Int, completion: @escaping (Result<[Comment], UserPostError>) -> Void) {
        
        guard let url = URL(string: commentsUrl + String(postId)) else {
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let comments = try decoder.decode([Comment].self, from: jsonData)
                completion(.success(comments))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        
        dataTask.resume()
    }
    
    
}
