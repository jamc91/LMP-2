//
//  NewsViewModel.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 30/05/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

final class NewsViewModel {
    
    @Published var posts: [Post] = []
    @Published var detailPost: Post?
    
    func getPosts(page: Int) {
        ApiService.shared.getData(with: EndPoint.posts(page)) { [weak self] (result: Result<PostsModel<Response>, ApiError>) in
            switch result {
            case .success(let posts):
                self?.posts.append(contentsOf: posts.response.posts)
            case .failure(let error):
                self?.printApiErrorMessage(error: error)
            }
        }
    }
    
    func getDetailPost(slug: String, completion: @escaping () -> Void) {
        ApiService.shared.getData(with: EndPoint.postDetail(slug)) { [weak self] (result: Result<PostsModel<Post>, ApiError>) in
            switch result {
            case .success(let posts):
                self?.detailPost = posts.response
                completion()
            case .failure(let error):
                self?.printApiErrorMessage(error: error)
            }
        }
    }
    
    private func printApiErrorMessage(error: ApiError) {
        switch error {
        case .decodingError(let errorDecoding):
            debugPrint(errorDecoding)
        case .httpError(let statusCode):
            print("error http \(statusCode)")
        case .unknown:
            print("error desconocido")
        }
    }
}
