//
//  PostsModel.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 06/05/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct PostsModel<T: Codable>: Codable {
    let response: T
}

struct Response: Codable {
    let posts: [Post]
}

struct Post: Codable, Identifiable, Equatable {
    let id = UUID()
    let cover: String
    let coverThumb: String
    let title: String
    let description: String
    let date: Date
    let slug: String
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case cover
        case coverThumb = "cover-thumb"
        case title
        case description
        case date
        case slug
        case content
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        cover = try container.decode(forKey: .cover, default: "")
        coverThumb = try container.decode(forKey: .coverThumb, default: "")
        title = try container.decode(forKey: .title, default: "")
        description = try container.decode(forKey: .description, default: "")
        date = try container.decode(forKey: .date, default: Date())
        slug = try container.decode(forKey: .slug, default: "")
        content = try container.decode(forKey: .content, default: "")
    }
}
