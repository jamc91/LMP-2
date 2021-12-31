//
//  DetailPostViewModel.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 21/12/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation
import SwiftUI

final class DetailPostViewModel: ObservableObject {
    
    @Published var detailPost: Post?
    @Published var isLoading = true
    
    init(slug: String) {
        getDetailPost(slug: slug)
    }
    
    func getDetailPost(slug: String) {
        ApiService.shared.getData(with: EndPoint.postDetail(slug)) { (response: Result<PostsModel<Post>, ApiError>) in
            switch response {
            case .success(let detailPost):
                self.detailPost = detailPost.response
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation {
                        self.isLoading = false
                    }
                }
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
