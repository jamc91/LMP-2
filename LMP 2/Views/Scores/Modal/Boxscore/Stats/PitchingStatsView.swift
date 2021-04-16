//
//  PitchingStatsView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 11/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct PitchingStatsView: View {
    
    typealias RowData = [(String, CGFloat)]
    var selectedTeam: SelectionTeam
    var team: TeamInformation
    var playerName: GameData
    var stats: BoxscoreTeamsContent
    
    init(content: LiveResponse, selectedTeam: SelectionTeam) {
        self.selectedTeam = selectedTeam
        self.playerName = content.gameData
        switch selectedTeam {
        case .away:
            self.team = content.gameData.teams.away
            self.stats = content.liveData.boxscore.teams.away
        case .home:
            self.team = content.gameData.teams.home
            self.stats = content.liveData.boxscore.teams.home
        }
    }
    
    var body: some View {
        Section(header: RowStatsView(type: .Header, content: headerData)) {
            VStack(spacing: 0) {
                ForEach(stats.pitchers, id: \.self) { id in
                    RowStatsView(type: .Stats, content: makePitchingArray(id: id))
                }
                RowStatsView(type: .Totals, content: totalsData)
            }
        }
    }
}

struct PitchingStatsView_Previews: PreviewProvider {
    static var previews: some View {
        PitchingStatsView(content: Constats.shared.live, selectedTeam: .home).previewLayout(.sizeThatFits)
    }
}

extension PitchingStatsView {
    
    func getPlayer(id: Int) -> (name: Person, stats: Player) {
        guard let name = playerName.players["ID\(id)"], let stats = stats.players["ID\(id)"] else { fatalError() }
        return (name, stats)
    }
    
    var headerData: RowData {
        [(text: "\(team.abbreviation) PITCHING", width: .infinity),
            (text: "IP", width: 20),
            (text: "H", width: 20),
            (text: "R", width: 20),
            (text: "ER", width: 20),
            (text: "BB", width: 20),
            (text: "SO", width: 20),
            (text: "HR", width: 25),
            (text: "ERA", width: 35)]
    }
    
    func makePitchingArray(id: Int) -> RowData {
        [
            (text: getPlayer(id: id).name.boxscoreName, width: .infinity),
            (text: String(getPlayer(id: id).stats.stats.pitching.inningsPitched), width: 20),
            (text: String(getPlayer(id: id).stats.stats.pitching.hits), width: 20),
            (text: String(getPlayer(id: id).stats.stats.pitching.runs), width: 20),
            (text: String(getPlayer(id: id).stats.stats.pitching.earnedRuns), width: 25),
            (text: String(getPlayer(id: id).stats.stats.pitching.baseOnBalls), width: 20),
            (text: String(getPlayer(id: id).stats.stats.pitching.strikeOuts), width: 20),
            (text: String(getPlayer(id: id).stats.stats.pitching.homeRuns), width: 25),
            (text: String(getPlayer(id: id).stats.seasonStats.pitching.era), width: 35)
        ]
    }
    
    var totalsData: RowData {
        [(text: "Totals:", width: .infinity),
            (text: String(stats.teamStats.pitching.inningsPitched), width: 20),
            (text: String(stats.teamStats.pitching.hits), width: 20),
            (text: String(stats.teamStats.pitching.runs), width: 20),
            (text: String(stats.teamStats.pitching.earnedRuns), width: 25),
            (text: String(stats.teamStats.pitching.baseOnBalls), width: 20),
            (text: String(stats.teamStats.pitching.strikeOuts), width: 20),
            (text: String(stats.teamStats.pitching.homeRuns), width: 25),
            (text: String(""), width: 35)]
    }
}
