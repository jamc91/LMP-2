//
//  VideoModel.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 03/01/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import Foundation

struct ContentResponse: Codable {
    
    let highlights: Highlights
    
}

struct Highlights: Codable {
    let highlights: HighlightsContent
}

struct HighlightsContent: Codable {
    let items: [Items]
}

struct Items: Codable, Identifiable {
    var id = UUID()
    let headline: String
    let image: HighlightsImage
    let date: String
    let duration: String
    let playbacks: [HighlightsPlaybacks]
    
    enum CodingKeys: String, CodingKey {
        case headline, image, date, duration, playbacks
    }
}

struct HighlightsImage: Codable {
    let cuts: [Cuts]
    
    struct Cuts: Codable {
        let aspectRatio: String
        let width: Int
        let height: Int
        let src: URL
    }
}

struct HighlightsPlaybacks: Codable {
    let name: String
    let url: URL
}
