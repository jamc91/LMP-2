//
//  HomeViewModel.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 25/12/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var scheduledGames = [ScheduleGame]()
    @Published var posts = [Post]()
    @Published var games = [Game]()
    @Published var isLoading = true
    let date = Date()
    
    init() {
        getCalendar()
        getPosts()
    }
    
    func getCalendar() {
        ApiService.shared.getData(with: EndPoint.calendar(date)) { (response: Result<CalendarResponse, ApiError>) in
            switch response {
            case .success(let response):
                self.scheduledGames = response.response.map { $0.value }.flatMap { $0 }
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func getPosts() {
        ApiService.shared.getData(with: EndPoint.posts(1)) { (response: Result<PostsModel<Response>, ApiError>) in
            switch response {
            case .success(let posts):
                self.posts = posts.response.posts
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
