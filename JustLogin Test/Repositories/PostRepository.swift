//
//  PostRepository.swift
//  JustLogin Test
//
//  Created by Irfan on 20/11/24.
//

import Foundation
import CoreData
import Combine

class PostRepository {
    private let apiService = ApiService.shared
    
    func fetchPosts() -> AnyPublisher<[Post], Error> {
        return apiService.getPosts()
    }
}
