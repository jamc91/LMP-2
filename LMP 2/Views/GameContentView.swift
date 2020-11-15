//
//  GameContentView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 15/09/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct GameContentView: View {
    
    @ObservedObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var teams = 0
    
    var body: some View {
        VStack {
            HStack (alignment: .center) {
                Spacer()
                HeaderScoreboardView(viewModel: viewModel)
                    .padding(.leading, 60)
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                })
                .padding(10)
                .foregroundColor(.secondary)
                .font(.system(size: 25))
            }
            ScrollView {
                HStack {
                    TeamNameBoxscoreView(awayName: viewModel.contentMLB.gameData.teams.away.teamName,
                                         homeName: viewModel.contentMLB.gameData.teams.home.teamName)
                    Spacer()
                    BoxscoreView(totalInnings: 1..<viewModel.contentMLB.liveData.linescore.getNumberInnings + 1,
                                 runs: viewModel.contentMLB.liveData.linescore.innings)
                    Spacer()
                    RHETextView(awayRuns: viewModel.contentMLB.liveData.linescore.teams.away.runs,
                                awayHits: viewModel.contentMLB.liveData.linescore.teams.away.hits,
                                awayErrors: viewModel.contentMLB.liveData.linescore.teams.away.errors,
                                homeRuns: viewModel.contentMLB.liveData.linescore.teams.home.runs,
                                homeHits: viewModel.contentMLB.liveData.linescore.teams.home.hits,
                                homeErrors: viewModel.contentMLB.liveData.linescore.teams.home.errors)
                    
                }.padding(.horizontal, 10)
                Picker("", selection: $teams) {
                    Text(viewModel.contentMLB.gameData.teams.away.teamName).tag(0)
                    Text(viewModel.contentMLB.gameData.teams.home.teamName).tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical)
                .padding(.horizontal, 10)
                if teams == 0 {
                    BattingHeaderSectionView(team: $viewModel.contentMLB.gameData.teams.away)
                    BattingView(team: $viewModel.contentMLB.liveData.boxscore.teams.away, player: $viewModel.contentMLB.gameData)
                    FooterView(team: $viewModel.contentMLB.liveData.boxscore.teams.away)
                    HeaderPitchingView(team: $viewModel.contentMLB.gameData.teams.away)
                    PitchingView(team: $viewModel.contentMLB.liveData.boxscore.teams.away)
                } else {
                    BattingHeaderSectionView(team: $viewModel.contentMLB.gameData.teams.home)
                    BattingView(team: $viewModel.contentMLB.liveData.boxscore.teams.home, player: $viewModel.contentMLB.gameData)
                    FooterView(team: $viewModel.contentMLB.liveData.boxscore.teams.home)
                    HeaderPitchingView(team: $viewModel.contentMLB.gameData.teams.home)
                    PitchingView(team: $viewModel.contentMLB.liveData.boxscore.teams.home)
                }
                FooterPitchingView(note: $viewModel.contentMLB.liveData.boxscore)
            }
        }
    }
}

struct GameContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameContentView(viewModel: ViewModel())
    }
}

struct HeaderScoreboardView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Group {
                    Text(viewModel.contentMLB.gameData.teams.away.abbreviation)
                    Text(viewModel.contentMLB.gameData.teams.home.abbreviation)
                }
                .font(.caption)
                .foregroundColor(.secondary)
                
            }
            VStack (alignment: .leading) {
                Group {
                    Text("\(viewModel.contentMLB.liveData.linescore.teams.away.runs)")
                    Text("\(viewModel.contentMLB.liveData.linescore.teams.home.runs)")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
            DiamondView(baseState: viewModel.contentMLB.liveData.linescore.offense.diamondState)
                .frame(width: 50, height: 50, alignment: .center)
                .scaleEffect(0.5)
            VStack (alignment: .leading) {
                Group {
                    Text("\(viewModel.contentMLB.liveData.linescore.isTopInning ? "Top" : "Bot") \(viewModel.contentMLB.liveData.linescore.currentInningOrdinal)")
                    Text("\(viewModel.contentMLB.liveData.linescore.strikes) \(viewModel.contentMLB.liveData.linescore.balls), \(viewModel.contentMLB.liveData.linescore.outs) out")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 10)
    }
}

struct BattingView: View {
    
    @Binding var team: BoxscoreTeamsInfo
    @Binding var player: GameData
    
    var body: some View {
        ForEach(team.batters, id: \.self) { person in
            if !team.players["ID\(person)"]!.position.type.contains("Pitcher") {
                if let safePerson = team.players["ID\(person)"], let safePlayer = player.players["ID\(person)"] {
                    HStack (spacing: 1) {
                        Text("\(safePlayer.boxscoreName), \(safePerson.position.abbreviation)")
                            .bold()
                            .font(.caption)
                            .padding(.leading, safePerson.gameStatus.isSubstitute  ? 20 : 0)
                        Spacer()
                        Group {
                            Text("\(safePerson.stats.batting.atBats)")
                            Text("\(safePerson.stats.batting.runs)")
                            Text("\(safePerson.stats.batting.hits)")
                            Text("\(safePerson.stats.batting.rbi)")
                            Text("\(safePerson.stats.batting.baseOnBalls)")
                            Text("\(safePerson.stats.batting.strikeOuts)")
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(width: 20, alignment: .center)
                        Group {
                            Text("\(safePerson.stats.batting.leftOnBase)")
                            Text(safePerson.seasonStats.batting.avg)
                            Text(safePerson.seasonStats.batting.ops)
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(width: 35, alignment: .center)
                    }
                    .padding(.vertical, 3)
                }
            }
        }
        .padding(.horizontal, 10)
        Divider()
        HStack (spacing: 1) {
            Text("TOTALS")
                .bold()
                .font(.caption)
            Spacer()
            Group {
                Text("\(team.teamStats.batting.atBats)")
                Text("\(team.teamStats.batting.runs)")
                Text("\(team.teamStats.batting.hits)")
                Text("\(team.teamStats.batting.rbi)")
                Text("\(team.teamStats.batting.baseOnBalls)")
                Text("\(team.teamStats.batting.strikeOuts)")
            }
            .font(Font.caption.bold())
            .frame(width: 20, alignment: .center)
            Text("\(team.teamStats.batting.leftOnBase)")
                .bold()
                .font(.caption)
                .frame(width: 35, alignment: .center)
            Text("")
                .frame(width: 70)
        }
        .padding(.horizontal, 10)
    }
}

struct BattingHeaderSectionView: View {
    
    @Binding var team: CGTeamsContent
    
    var body: some View {
        HStack (spacing: 1) {
            Text("\(team.abbreviation) BATTING")
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
            Group {
                Text("AB")
                Text("R")
                Text("H")
                Text("RBI")
                Text("BB")
                Text("SO")
            }
            .font(.caption)
            .foregroundColor(.secondary)
            .frame(width: 20, alignment: .center)
            Group {
                Text("LOB")
                Text("AVG")
                Text("OPS")
            }
            .font(.caption)
            .foregroundColor(.secondary)
            .frame(width: 35, alignment: .center)
        }
        .padding(.horizontal, 10)
        Divider()
    }
}

struct FooterView: View {
    
    @Binding var team: BoxscoreTeamsInfo
    
    var body: some View {
        VStack {
            ForEach(team.note) { note in
                Group {
                    HStack (alignment: .top ,spacing: 0) {
                        Text("\(note.label):")
                            .bold()
                        Text(note.value)
                        Spacer()
                    }
                }
                .font(.caption)
            }
            ForEach(team.info) { info in
                VStack (alignment: .leading) {
                    Text(info.title)
                        .bold()
                        .font(.caption)
                    ForEach(info.fieldList) { infoItem in
                        Group {
                            HStack (alignment: .top ,spacing: 0) {
                                Text("\(infoItem.label): ")
                                    .bold()
                                Text(infoItem.value)
                                Spacer()
                            }
                        }
                        .font(.caption)
                    }
                }.padding(.vertical, 10)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
    }
}

struct HeaderPitchingView: View {
    
    @Binding var team: CGTeamsContent
    
    var body: some View {
        HStack (spacing: 1) {
            Text("\(team.abbreviation) PITCHING")
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
            Group {
                Text("IP")
                Text("H")
                Text("R")
                Text("ER")
                Text("BB")
                Text("SO")
                Text("HR")
            }
            .font(.caption)
            .foregroundColor(.secondary)
            .frame(width: 20, alignment: .center)
            Group {
                Text("ERA")
            }
            .font(.caption)
            .foregroundColor(.secondary)
            .frame(width: 35, alignment: .center)
        }
        .padding(.horizontal, 10)
        Divider()
    }
}

struct PitchingView: View {
    
    @Binding var team: BoxscoreTeamsInfo
    
    var body: some View {
        ForEach(team.pitchers, id: \.self) { person in
            if let safePerson = team.players["ID\(person)"] {
                    HStack (spacing: 1) {
                        Text("\(safePerson.person.fullName), \(safePerson.position.abbreviation)")
                            .bold()
                            .font(.caption)
                        Spacer()
                        Group {
                            Text("\(safePerson.stats.pitching.inningsPitched)")
                            Text("\(safePerson.stats.pitching.hits)")
                            Text("\(safePerson.stats.pitching.runs)")
                            Text("\(safePerson.stats.pitching.earnedRuns)")
                            Text("\(safePerson.stats.pitching.baseOnBalls)")
                            Text("\(safePerson.stats.pitching.strikeOuts)")
                            Text("\(safePerson.stats.pitching.homeRuns)")
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(width: 20, alignment: .center)
                        Group {
                            Text("\(safePerson.seasonStats.pitching.era)")
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(width: 35, alignment: .center)
                    }
                    .padding(.vertical, 3)
                }
            
        }
        .padding(.horizontal, 10)
        Divider()
        HStack (spacing: 1) {
            Text("TOTALS")
                .bold()
                .font(.caption)
            Spacer()
            Group {
                Text("\(team.teamStats.pitching.inningsPitched)")
                Text("\(team.teamStats.pitching.hits)")
                Text("\(team.teamStats.pitching.runs)")
                Text("\(team.teamStats.pitching.earnedRuns)")
                Text("\(team.teamStats.pitching.baseOnBalls)")
                Text("\(team.teamStats.pitching.strikeOuts)")
                Text("\(team.teamStats.pitching.homeRuns)")
            }
            .font(Font.caption.bold())
            .frame(width: 20, alignment: .center)
            Text("")
                .frame(width: 35)
        }
        .padding(.horizontal, 10)
    }

}

struct FooterPitchingView: View {
    
    @Binding var note: CBoxscore
    
    var body: some View {
        VStack (alignment: .leading) {
            ForEach(note.info) { note in
                Group {
                    HStack (alignment: .top ,spacing: 0) {
                        Text("\(note.label): ")
                            .bold()
                        Text(note.value)
                        Spacer()
                    }
                }
                .font(.caption)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
    }
}
