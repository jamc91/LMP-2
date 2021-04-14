//
//  tabBarView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 04/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View {
        TabView {
            ScoresView()
            Text("Standings").tabItem { Label("Standings", systemImage: "flag.fill") }
            Text("News").tabItem { Label("News", systemImage: "newspaper.fill") }
            Text("Stats").tabItem { Label("Stats", systemImage: "chart.bar.fill") }
            Text("Settings").tabItem { Label("Settings", systemImage: "gearshape.fill") }
        }
        .accentColor(.black)
    }
}

struct TabBarView_Previews: PreviewProvider {
    
    static var previews: some View {
        TabBarView().environmentObject(ContentViewModel(games: Constats.shared.games.dates.flatMap { $0.games }, standingMLB: Constats.shared.standingMLB, standingLMP: Constats.shared.standingLMP, liveContent: Constats.shared.live, videoList: Constats.shared.content))
    }
}
