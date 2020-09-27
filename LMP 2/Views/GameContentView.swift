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
    @State private var date = Date()
    var body: some View {
        ScrollView {
            
            DatePicker("", selection: $date, displayedComponents: .date)
                .labelsHidden()
                .accentColor(.secondary)
                .cornerRadius(18)
            
        }.navigationBarItems(leading: HeaderScoreboardView(viewModel: viewModel)
                                .offset(x: UIScreen.main.bounds.width / 7))
        .onAppear(perform: {
            self.viewModel.fetchGames(url: URL(string: "https://statsapi.mlb.com/api/v1.1/game/\(gamePk)/feed/live?language=es")!, placeholder: viewModel.contentMLB) { (content: ContentResults) in
                self.viewModel.contentMLB = content
            }
        })
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
                    Text(viewModel.contentMLB.gameData?.teams.away.abbreviation ?? "TBD")
                    Text(viewModel.contentMLB.gameData?.teams.home.abbreviation ?? "TBD")
                }
                .font(.caption)
                .foregroundColor(.secondary)
                
            }
            VStack (alignment: .leading) {
                Group {
                    Text("\(viewModel.contentMLB.liveData?.linescore?.teams.away.runs ?? 0)")
                    Text("\(viewModel.contentMLB.liveData?.linescore?.teams.home.runs ?? 0)")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
          /*  DiamondView(linescore: viewModel.contentMLB.linescore)
                .frame(width: 50, height: 50, alignment: .center)
                .scaleEffect(0.5)*/
            VStack (alignment: .leading) {
                Group {
                    Text("\(viewModel.contentMLB.liveData?.linescore?.isTopInning ?? false ? "Top" : "Bot") \(viewModel.contentMLB.liveData?.linescore?.currentInningOrdinal ?? "0")")
                    Text("\(viewModel.contentMLB.liveData?.linescore?.strikes ?? 0) \(viewModel.contentMLB.liveData?.linescore?.balls ?? 0), \(viewModel.contentMLB.liveData?.linescore?.outs ?? 0) out")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
        }
    }
}
