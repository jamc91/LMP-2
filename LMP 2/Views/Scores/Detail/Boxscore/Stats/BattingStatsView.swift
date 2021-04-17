//
//  BattingStatsView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 11/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct BattingStatsView: View {
    
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
                ForEach(stats.battersBoxscore, id: \.self) { id in
                    RowStatsView(type: .Stats, content: makeBattingArray(id: id))
                        .padding(getPlayer(id: id).stats.gameStatus.isSubstitute ? .leading : .init())
                        .background(Color(getPlayer(id: id).stats.gameStatus.isCurrentBatter && playerName.status.abstractGameState == .live ? .systemGray5 : .systemBackground))
                        
                }
                RowStatsView(type: .Totals, content: totalsData)
                FotterBattingStatsView(team: stats)
            }
        }
    }
}

struct BattingStatsView_Previews: PreviewProvider {
    static var previews: some View {
        BattingStatsView(content: Constats.shared.live, selectedTeam: .home).previewLayout(.sizeThatFits).preferredColorScheme(.light)
    }
}

extension BattingStatsView {
    
    func getPlayer(id: Int) -> (name: Person, stats: Player) {
        guard let name = playerName.players["ID\(id)"], let stats = stats.players["ID\(id)"] else { fatalError() }
        return (name, stats)
    }
    
    var headerData: RowData {
        [("\(team.abbreviation) BATTING", CGFloat.infinity), ("AB", CGFloat(20)), ("R", CGFloat(15)), ("H", CGFloat(15)), ("RBI", CGFloat(25)), ("BB", CGFloat(20)), ("SO", CGFloat(20)), ("LOB", CGFloat(25)), ("AVG", CGFloat(35)), ("OPS", CGFloat(35))]
    }
    
    func makeBattingArray(id: Int) -> RowData {
        let player = getPlayer(id: id)
        return [(text: "\(player.name.boxscoreName), \(player.stats.position.abbreviation)", width: .infinity),
                (text: String(player.stats.stats.batting.atBats), width: 20),
            (text: String(player.stats.stats.batting.runs), width: 15),
            (text: String(player.stats.stats.batting.hits), width: 15),
            (text: String(player.stats.stats.batting.rbi), width: 25),
            (text: String(player.stats.stats.batting.baseOnBalls), width: 20),
            (text: String(player.stats.stats.batting.strikeOuts), width: 20),
            (text: String(player.stats.stats.batting.leftOnBase), width: 25),
            (text: String(player.stats.seasonStats.batting.avg), width: 35),
            (text: String(player.stats.seasonStats.batting.ops), width: 35)]
    }
    
    var totalsData: RowData {
        [(text: "Totals:", width: .infinity),
            (text: String(stats.teamStats.batting.atBats), width: 20),
            (text: String(stats.teamStats.batting.runs), width: 15),
            (text: String(stats.teamStats.batting.hits), width: 15),
            (text: String(stats.teamStats.batting.rbi), width: 25),
            (text: String(stats.teamStats.batting.baseOnBalls), width: 20),
            (text: String(stats.teamStats.batting.strikeOuts), width: 20),
            (text: String(stats.teamStats.batting.leftOnBase), width: 25),
            (text: String(""), width: 73)]
    }
}
