//
//  Constants.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 08/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct Constats {
    static let shared = Constats()
    let standingLMP: StandingLMP = Bundle.main.decode("standingsLMP.json")
    let standingMLB: StandingMLB = Bundle.main.decode("standingsMLB.json")
    let games: ScheduleResponse = Bundle.main.decode("schedule.json")
    let live: LiveResponse = Bundle.main.decode("live.json")
    let content: ContentResponse = Bundle.main.decode("content.json")
    let posts: PostsModel<Response> = Bundle.main.decode("posts.json")
    let detailPost: PostsModel<Post> = Bundle.main.decode("detailpost.json")
}
