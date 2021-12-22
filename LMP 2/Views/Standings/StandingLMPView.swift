//
//  StandingLMPView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 05/05/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct StandingLMPView: View {
    
    @StateObject var standingsViewModel = StandingsViewModel()
    @State private var selectionStanding: StandingLeague = .regular
    
    var body: some View {
        NavigationView {
            List {
                picker
                switch selectionStanding {
                case .regular:
                    ForEach(RegularType.allCases, id: \.self) { standing in
                        Section(header: RegularHeaderSection(title: standing.rawValue, type: standing)) {
                            if let standingModel = standingsViewModel.standingLMP {
                                standing.getStandingList(standing: standingModel)
                            }
                        }
                    }
                case .playoffs:
                    ForEach(PlayoffsType.allCases, id: \.self) { standing in
                        Section(header: PlayoffsHeaderSection(title: standing.rawValue)) {
                            if let standingModel = standingsViewModel.standingLMP {
                                standing.getStandingList(standing: standingModel)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Standings")
            .listStyle(.plain)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .tabItem { Label("Standings", systemImage: "flag.fill") }
    }
}

struct StandingLMPView_Previews: PreviewProvider {
    static var previews: some View {
        StandingLMPView()
    }
}

extension StandingLMPView {
    var picker: some View {
        Picker("", selection: $selectionStanding) {
            ForEach(StandingLeague.allCases, id: \.self) { league in
                Text(league.rawValue.capitalized)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

struct RegularHeaderSection: View {
    
    var title: String
    var type: RegularType
    
    var body: some View {
        switch type {
        case .first, .second, .general:
            RowStanding(
                content: [
                    (text: title.uppercased(), width: .infinity),
                (text: "W", width: 30),
                (text: "L", width: 30),
                (text: "PCT", width: 45),
                (text: "GB", width: 35),
                (text: "PTS", width: 45),
            ],
            font: .caption)
        case .points:
            RowStanding(
                content: [
                    (text: title.uppercased(), width: .infinity),
                (text: "1v", width: 40),
                (text: "2v", width: 40),
                (text: "TOTAL", width: 45)
            ],
            font: .caption)
        }
    }
}

struct PlayoffsHeaderSection: View {
    
    var title: String
    
    var body: some View {
            RowStanding(
                content: [
                (text: title, width: .infinity),
                (text: "W", width: 40),
                (text: "L", width: 40),
                (text: "PCT", width: 45)
            ],
            font: .caption)
    }
}


