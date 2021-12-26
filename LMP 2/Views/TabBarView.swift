//
//  tabBarView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 04/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    
    @EnvironmentObject var scoresViewModel: ScoresViewModel
    let didTapCalendarButton: () -> Void
    
    var body: some View {
        TabView {
            ScoresView(didTapCalendarButton: didTapCalendarButton)
            StandingLMPView()
            NewsView()
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    
    static var previews: some View {
        TabBarView(didTapCalendarButton: {})
    }
}
