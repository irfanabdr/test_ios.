//
//  MainViewModel.swift
//  JustLogin Test
//
//  Created by Irfan on 20/11/24.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var state: AppState = .inital
    
    private let postRepository = PostRepository()
    private var cancellables = Set<AnyCancellable>()
    
    func fetchPosts() {
        state = .loading
        
        postRepository.fetchPosts()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(_) = completion {
                    self.state = .error("No posts available.")
                }
            } receiveValue: { posts in
                self.posts = posts
                self.state = .success
            }
            .store(in: &cancellables)
    }
}
