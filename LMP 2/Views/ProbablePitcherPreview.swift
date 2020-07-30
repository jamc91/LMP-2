//
//  ProbablePitcherPreview.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 23/07/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProbablePitcherPreview: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        ForEach(viewModel.gamesMLB, id: \.id) { date in
            ForEach(date.games, id: \.id) { game in
                ProbablePitcherView2(team: game.teams)
            }
        }
    }
}

struct ProbablePitcherPreview_Previews: PreviewProvider {
    static var previews: some View {
        ProbablePitcherPreview()
    }
}

struct ProbablePitcherView2: View {
    
    var team: Teams
    
    var body: some View{
        VStack (alignment: .center) {
            Text("Probable Pitcher")
                .foregroundColor(.secondary)
            
        HStack {
            team.away.probablePitcher.map { pitcher in
                PitcherAwayView2(pitcherURL: team.away.probablePitcher?.imageURL, pitcher: pitcher)
            }
            
            Spacer()
            team.home.probablePitcher.map { pitcher in
                PitcherHomeView2(pitcherURL: team.home.probablePitcher?.imageURL, pitcher: pitcher)
            }
            
        }
        }.padding(.top, 5)
         .padding(.bottom, 20)
         .padding(.horizontal)
    }
}


struct PitcherAwayView2: View {
    
    var pitcherURL: URL?
    var pitcher: ProbablePitcher
    
    var body: some View {
        HStack {
            WebImage(url: pitcherURL ?? URL(string: ""))
                .placeholder(Image("default-batter"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(Color(.systemGray5))
                .clipShape(Circle())
                .frame(width: 60, height: 60, alignment: .center)
            VStack (alignment: .leading) {
                Text(pitcher.boxscoreName).font(.caption)
                Text("\(pitcher.pitchHand.code)HP #\(pitcher.primaryNumber ?? "")").font(.caption).foregroundColor(.secondary)
                HStack {
                    pitcher.stats[3].stats.wins.map { wins in
                        Text("\(wins)").font(.caption).foregroundColor(.secondary)
                    }
                    pitcher.stats[3].stats.losses.map { losses in
                        Text("- \(losses)").font(.caption).foregroundColor(.secondary)
                    }
                    pitcher.stats[3].stats.era.map { era in
                        Text("\(era) ERA").font(.caption).foregroundColor(.secondary)
                    }
                }
            }.padding(.leading, 5)
        }
    }
}

struct PitcherHomeView2: View {
    
    var pitcherURL: URL?
    var pitcher: ProbablePitcher
    
    
    var body: some View {
        HStack {
            VStack (alignment: .trailing) {
                Text(pitcher.boxscoreName).font(.caption)
                Text("\(pitcher.pitchHand.code)HP #\(pitcher.primaryNumber ?? "")").font(.caption).foregroundColor(.secondary)
                    HStack {
                        pitcher.stats[3].stats.wins.map { wins in
                            Text("\(wins)").font(.caption).foregroundColor(.secondary)
                        }
                        pitcher.stats[3].stats.losses.map { losses in
                            Text("- \(losses)").font(.caption).foregroundColor(.secondary)
                        }
                        pitcher.stats[3].stats.era.map { era in
                            Text("\(era) ERA").font(.caption).foregroundColor(.secondary)
                        }
                    }
            
            }.padding(.trailing, 5)
            WebImage(url: pitcherURL ?? URL(string: ""))
                .placeholder(Image("default-batter"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(Color(.systemGray5))
                .clipShape(Circle())
                .frame(width: 60, height: 60, alignment: .center)
        }
    }
}
