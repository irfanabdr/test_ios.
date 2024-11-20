//
//  ApiService.swift
//  JustLogin Test
//
//  Created by Irfan on 20/11/24.
//

import Foundation
import Alamofire
import Combine

class ApiService {
    static let shared = ApiService()
    
    func getPosts() -> AnyPublisher<[Post], Error> {
        let url = "https://jsonplaceholder.org/posts"
        return AF.request(url)
            .validate()
            .publishDecodable(type: [Post].self)
            .value()
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
}
