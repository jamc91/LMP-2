//
//  StandingLMPView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 05/05/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct StandingLMPView: View {
    
    @EnvironmentObject var viewModel: ContentViewModel
    @State private var selectionStanding: StandingLeague = .regular
    
    var body: some View {
        NavigationView {
            List {
                picker
                switch selectionStanding {
                case .regular:
                    ForEach(RegularType.allCases, id: \.self) { standing in
                        Section(header: Text(standing.rawValue)) {
                            if let standingModel = viewModel.standingLMP {
                                standing.getStandingList(standing: standingModel)
                            }
                        }
                    }
                case .playoffs:
                    ForEach(PlayoffsType.allCases, id: \.self) { standing in
                        Section(header: Text(standing.rawValue)) {
                            if let standingModel = viewModel.standingLMP {
                                standing.getStandingList(standing: standingModel)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Standings")
        }
        .tabItem { Label("Standings", systemImage: "flag.fill") }
        .animation(nil)
    }
}

struct StandingLMPView_Previews: PreviewProvider {
    static var previews: some View {
        StandingLMPView()
            .environmentObject(ContentViewModel(standingLMP: Constats.shared.standingLMP))
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
