//
//  GameContentView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 15/09/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct GameContentView: View {
    
    @ObservedObject var contentViewModel: ContentViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedTeam = SelectionTeam.home
    
    var body: some View {
        TabView {
            if let boxscore = contentViewModel.live {
                BoxscoreView(boxscore: boxscore, selectedTeam: $selectedTeam) {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            if let videoList = contentViewModel.content?.highlights.highlights.items, !videoList.isEmpty {
            VideosView(videoData: videoList)
            }
        }
    }
}

struct GameContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        GameContentView(contentViewModel: ContentViewModel(liveContent: Constats.shared.live, videoList: Constats.shared.content))

    }
}

struct BoxscoreView: View {
    
    var boxscore: LiveResponse
    @Binding var selectedTeam: SelectionTeam
    let dismiss: () -> Void
    
    var body: some View {
        VStack {
            DismissButton(dismiss: { dismiss() })
            ScrollView {
                LinescoreView(teams: boxscore.gameData.teams, linescore: boxscore.liveData.linescore)
                Divider()
                SelectorTeamPickerView(awayTeamName: boxscore.gameData.teams.away.teamName, homeTeamName: boxscore.gameData.teams.home.teamName, selectionTeam: $selectedTeam)
                switch selectedTeam {
                case .away:
                    TeamContentView(
                        teamContent: boxscore.gameData.teams.away,
                        teamInfo: boxscore.liveData.boxscore.teams.away,
                        player: boxscore.gameData)
                case .home:
                    TeamContentView(
                        teamContent: boxscore.gameData.teams.home,
                        teamInfo: boxscore.liveData.boxscore.teams.home,
                        player: boxscore.gameData)
                }
                FooterPitchingView(note: boxscore.liveData.boxscore.info)
            }
        }
        .tabItem { Label("Boxscore", systemImage: "list.bullet") }
    }
}

struct DismissButton: View {
    
    let dismiss: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark.circle.fill")
            })
            .padding()
            .foregroundColor(.secondary)
            .imageScale(.large)
        }
    }
}

struct TeamContentView: View {
    
    var teamContent: TeamInformation
    var teamInfo: BoxscoreTeamsContent
    var player: GameData
    
    var body: some View {
        BattingHeaderSectionView(team: teamContent)
        BattingView(team: teamInfo,
                    player: player)
        FooterView(team: teamInfo)
        HeaderPitchingView(team: teamContent)
        PitchingView(team: teamInfo, player: player)
    }
}

struct BattingView: View {
    
    var team: BoxscoreTeamsContent
    var player: GameData
    
    var body: some View {
        ForEach(team.batters, id: \.self) { person in
            if let safePerson = team.players["ID\(person)"], let safePlayer = player.players["ID\(person)"] {
                TextListView(name: "\(safePlayer.boxscoreName), \(safePerson.position.abbreviation)",
                             nameFontWeight: .bold,
                             nameColor: .primary,
                             info: [(text: "\(safePerson.stats.batting.atBats)", width: 20),
                                    (text: "\(safePerson.stats.batting.runs)", width: 20),
                                    (text: "\(safePerson.stats.batting.hits)", width: 20),
                                    (text: "\(safePerson.stats.batting.rbi)", width: 20),
                                    (text: "\(safePerson.stats.batting.baseOnBalls)", width: 20),
                                    (text: "\(safePerson.stats.batting.strikeOuts)", width: 20),
                                    (text: "\(safePerson.stats.batting.leftOnBase)", width: 20),
                                    (text: "\(safePerson.seasonStats.batting.avg)", width: 35),
                                    (text: "\(safePerson.seasonStats.batting.ops)", width: 35)],
                             isSubstitute: safePerson.gameStatus.isSubstitute,
                             textFontWeight: .regular,
                             textColor: .secondary)
                    .background(Color( safePerson.gameStatus.isCurrentBatter && player.status.abstractGameState == .live ? .systemGray6 : .clear)
                                    .cornerRadius(5)
                                    .padding(.horizontal, 5))
            }
        }
        Divider()
        HStack (spacing: 5) {
            TextListView(name: "TOTALS",
                         nameFontWeight: .bold,
                         nameColor: .primary,
                         info: [(text: "\(team.teamStats.batting.atBats)", width: 20),
                                (text: "\(team.teamStats.batting.runs)", width: 20),
                                (text: "\(team.teamStats.batting.hits)", width: 20),
                                (text: "\(team.teamStats.batting.rbi)", width: 20),
                                (text: "\(team.teamStats.batting.baseOnBalls)", width: 20),
                                (text: "\(team.teamStats.batting.strikeOuts)", width: 20),
                                (text: "\(team.teamStats.batting.leftOnBase)", width: 20)],
                         textFontWeight: .bold,
                         textColor: .primary)
            Text("")
                .frame(width: 75)
        }
    }
}

struct BattingHeaderSectionView: View {
    
    var team: TeamInformation
    
    var body: some View {
        TextListView(name: "\(team.abbreviation) BATTING",
                     nameFontWeight: .regular,
                     nameColor: .secondary,
                     info:
                        [(text: "AB",  width: 20),
                         (text: "R",   width: 20),
                         (text: "H",   width: 20),
                         (text: "RBI", width: 20),
                         (text: "BB",  width: 20),
                         (text: "SO",  width: 20),
                         (text: "LOB", width: 20),
                         (text: "AVG", width: 35),
                         (text: "OPS", width: 35)],
                     textFontWeight: .regular,
                     textColor: .secondary)
        Divider()
    }
}

struct FooterView: View {
    
    var team: BoxscoreTeamsContent
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                VStack (alignment: .leading) {
                    ForEach(team.note) { note in
                        TextInfoView(label: note.label, value: note.value)
                    }
                }
                .padding(.bottom)
                ForEach(team.info.filter { $0.title == "BATTING" }) { teamInfo in
                    Text(teamInfo.title)
                        .font(.caption)
                        .bold()
                    ForEach(teamInfo.fieldList) { item in
                        TextInfoView(label: item.label, value: item.value)
                    }
                }
            }
            Spacer()
        }
    }
}

struct HeaderPitchingView: View {
    
    var team: TeamInformation
    
    var body: some View {
        TextListView(name: "\(team.abbreviation) PITCHING",
                     nameFontWeight: .regular,
                     nameColor: .secondary,
                     info:
                        [(text: "IP", width: 25),
                         (text: "H", width: 20),
                         (text: "R", width: 20),
                         (text: "ER", width: 20),
                         (text: "BB", width: 20),
                         (text: "SO", width: 20),
                         (text: "HR", width: 20),
                         (text: "ERA", width: 35)],
                     textFontWeight: .regular,
                     textColor: .secondary)
        Divider()
    }
}

struct PitchingView: View {
    
    var team: BoxscoreTeamsContent
    var player: GameData
    
    var body: some View {
        ForEach(team.pitchers, id: \.self) { person in
            if let safePerson = team.players["ID\(person)"], let safePlayer = player.players["ID\(person)"] {
                TextListView(name: "\(safePlayer.boxscoreName), \(safePerson.position.abbreviation)",
                             nameFontWeight: .bold,
                             nameColor: .primary,
                             info: [(text: "\(safePerson.stats.pitching.inningsPitched)", width: 25),
                                    (text: "\(safePerson.stats.pitching.hits)", width: 20),
                                    (text: "\(safePerson.stats.pitching.runs)", width: 20),
                                    (text: "\(safePerson.stats.pitching.earnedRuns)", width: 20),
                                    (text: "\(safePerson.stats.pitching.baseOnBalls)", width: 20),
                                    (text: "\(safePerson.stats.pitching.strikeOuts)", width: 20),
                                    (text: "\(safePerson.stats.pitching.homeRuns)", width: 20),
                                    (text: "\(safePerson.seasonStats.pitching.era)", width: 35)],
                             isSubstitute: false,
                             textFontWeight: .regular,
                             textColor: .secondary)
                    .background(Color( safePerson.gameStatus.isCurrentPitcher && player.status.abstractGameState == .live ? .systemGray6 : .clear)
                                    .cornerRadius(5)
                                    .padding(.horizontal, 5))
            }
        }
        Divider()
        HStack (spacing: 5) {
            TextListView(name: "TOTALS",
                         nameFontWeight: .bold,
                         nameColor: .primary,
                         info: [(text: "\(team.teamStats.pitching.inningsPitched)", width: 25),
                                (text: "\(team.teamStats.pitching.hits)", width: 20),
                                (text: "\(team.teamStats.pitching.runs)", width: 20),
                                (text: "\(team.teamStats.pitching.earnedRuns)", width: 20),
                                (text: "\(team.teamStats.pitching.baseOnBalls)", width: 20),
                                (text: "\(team.teamStats.pitching.strikeOuts)", width: 20),
                                (text: "\(team.teamStats.pitching.homeRuns)", width: 20)],
                         textFontWeight: .bold,
                         textColor: .primary)
            Text("")
                .frame(width: 35)
        }
    }
}

struct FooterPitchingView: View {
    
    var note: [FieldList]
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                ForEach(note) { note in
                    TextInfoView(label: note.label, value: note.value)
                }
            }
            Spacer()
        }
        .padding(.horizontal, 5)
    }
}
