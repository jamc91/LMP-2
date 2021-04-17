//
//  StatsTests.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 16/04/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

//import SwiftUI
//
//struct StatsTests: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//struct StatsTests_Previews: PreviewProvider {
//    static var previews: some View {
//        StatsTests()
//    }
//}
//
//struct StatsColumn: View {
//    
//    let header: [String]
//    let info: [[String]]
//    
//    var body: some View {
//        ZStack(alignment: .top) {
//            Rectangle()
//                .fill(Color(.systemGray6))
//                .frame(maxWidth: .infinity)
//                .frame(height: 25)
//            HStack(spacing: 5) {
//                ForEach(Array(zip(header, info)), id: \.0.self) { (text, column) in
//                    VStack(alignment: header.first! == text ? .leading : .center) {
//                        Text(text)
//                            .font(.caption)
//                            .foregroundColor(.secondary)
//                            .frame(height: 25)
//                        ForEach(column, id: \.self) { row in
//                            Text(row)
//                                .font(.caption)
//                                .fontWeight(header.first! == text ? .semibold : .regular)
//                                .frame(height: 25)
//                        }
//                    }
//                    if header.first! == text {
//                        Spacer()
//                    }
//                }
//            }
//            .padding(.horizontal, 5)
//            
//        }
//    }
//}

//StatsColumn(header: ["BATTING", "AB", "R", "H", "RBI", "BB", "SO", "LOB", "AVG", "OPS"], info: [
//    stats.battersBoxscore.map { String(getPlayer(id: $0).name.boxscoreName) },
//    stats.battersBoxscore.map { String(getPlayer(id: $0).stats.stats.batting.atBats) },
//    stats.battersBoxscore.map { String(getPlayer(id: $0).stats.stats.batting.runs) },
//    stats.battersBoxscore.map { String(getPlayer(id: $0).stats.stats.batting.hits) },
//    stats.battersBoxscore.map { String(getPlayer(id: $0).stats.stats.batting.rbi) },
//    stats.battersBoxscore.map { String(getPlayer(id: $0).stats.stats.batting.baseOnBalls) },
//    stats.battersBoxscore.map { String(getPlayer(id: $0).stats.stats.batting.strikeOuts) },
//    stats.battersBoxscore.map { String(getPlayer(id: $0).stats.stats.batting.leftOnBase) },
//    stats.battersBoxscore.map { String(getPlayer(id: $0).stats.seasonStats.batting.avg) },
//    stats.battersBoxscore.map { String(getPlayer(id: $0).stats.seasonStats.batting.ops) }])
