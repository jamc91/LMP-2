//
//  StandingPlayoffsView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 05/05/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct StandingPlayoffsView: View {
    let content: [PlayoffsContent]?
    
    var body: some View {
        ForEach(content ?? .init()) { team in
            VStack {
                RowStanding(
                    content:
                        [
                            (text: team.awayTeamName, width: .infinity),
                            (text: "\(team.awayWins)", width: 40),
                            (text: "\(team.awayLosses)", width: 40),
                            (text: team.awayGamesPlayed, width: 45),
                        ])
                RowStanding(
                    content:
                        [
                            (text: team.homeTeamName, width: .infinity),
                            (text: "\(team.homeWins)", width: 40),
                            (text: "\(team.homeLosses)", width: 40),
                            (text: team.homeGamesPlayed, width: 45),
                        ])
            }
        }
    }
}

struct StandingPlayoffsView_Previews: PreviewProvider {
    static var previews: some View {
        StandingPlayoffsView(content: Constats.shared.standingLMP.response.playoffs?.repesca)
    }
}
