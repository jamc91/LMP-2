//
//  GameContentView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 15/09/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct GameContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    var gamePk: Int
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    viewModel.isPresentContent = false
                }, label: {
                    Image(systemName: "xmark.circle.fill")
            })
            .padding(10)
            .foregroundColor(.gray)
            .font(.system(size: 30))
            }
            ScrollView {
                HeaderScoreboardView(viewModel: viewModel)
                HStack {
                    TeamNameBoxscoreView(awayName: viewModel.contentMLB.gameData.teams.away.teamName, homeName: viewModel.contentMLB.gameData.teams.home.teamName)
                    BoxscoreView(totalInnings: 1..<viewModel.contentMLB.liveData.linescore.getNumberInnings + 1, runs: viewModel.contentMLB.liveData.linescore.innings)
                    RHETextView(awayRuns: viewModel.contentMLB.liveData.linescore.teams.away.runs, awayHits: viewModel.contentMLB.liveData.linescore.teams.away.hits, awayErrors: viewModel.contentMLB.liveData.linescore.teams.away.errors, homeRuns: viewModel.contentMLB.liveData.linescore.teams.home.runs, homeHits: viewModel.contentMLB.liveData.linescore.teams.home.hits, homeErrors: viewModel.contentMLB.liveData.linescore.teams.home.errors)
                }
            }
            .navigationTitle("Boxscore")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct GameContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameContentView(gamePk: 0)
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
    }
}
