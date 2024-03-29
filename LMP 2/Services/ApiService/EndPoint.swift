//
//  EndPoint.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 12/20/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import Foundation

enum EndPoint {
    case schedule(String)
    case live(String)
    case standingMLB
    case standingLMP
    case videoList(String)
    case image(Int)
    case posts(Int)
    case postDetail(String)
    case calendar(Date)
    case leaders(String, Int, String)
}

extension EndPoint: RequestBuilder {
    var urlRequest: URLRequest {
        switch self {
        case .schedule(let date):
            return EndPoint.buildURLRequest(urlString: "https://statsapi.mlb.com/api/v1/schedule?language=es&leagueId=103,104,132,162&sportId=1,17&date=\(date)&sortBy=gameStatus&sortBy=gameDate&hydrate=team,linescore(matchup,runners),person,stats,probablePitcher,decisions")
        case .live(let gamePk):
            return EndPoint.buildURLRequest(urlString: "https://statsapi.mlb.com/api/v1.1/game/\(gamePk)/feed/live")
        case .standingMLB:
            return EndPoint.buildURLRequest(urlString: "https://statsapi.mlb.com/api/v1/standings?leagueId=103,104&standingsTypes=regularSeason&hydrate=division,team")
        case .standingLMP:
            return EndPoint.buildURLRequest(urlString: "https://api.lmp.mx/3.0.0/standing")
        case .videoList(let gamePk):
            return EndPoint.buildURLRequest(urlString: "https://statsapi.mlb.com/api/v1/game/\(gamePk)/content")
        case .image(let imageId):
            return EndPoint.buildURLRequest(urlString: "https://content.mlb.com/images/headshots/current/60x60/\(imageId)@2x.png")
        case .posts(let page):
            return EndPoint.buildURLRequest(urlString: "https://api.lmp.mx/3.0.0/posts?page=\(page)")
        case .postDetail(let slug):
            return EndPoint.buildURLRequest(urlString: "https://api.lmp.mx/3.0.0/posts/\(slug)?param=slug")
        case .calendar(let date):
            return EndPoint.buildURLRequest(urlString: "https://api.lmp.mx/3.0.0/calendar?date=\(date.dateFormatterForCalendar())")
        case .leaders(let mode, let limit, let type):
            return EndPoint.buildURLRequest(urlString: "https://api.lmp.mx/3.0.0/leaders?mode=\(mode)&column=avg&order=desc&limit=\(limit)&type=\(type)&year=2021&cache=2")
        }
    }
    
    static func buildURLRequest(urlString: String) -> URLRequest {
        guard let url = URL(string: urlString) else { preconditionFailure("Formato de URL Invalida.") }
        let request = URLRequest(url: url)
        return request
    }
}
