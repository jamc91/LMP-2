//
//  StandingRegularView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 05/05/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct StandingRegularView: View {
    let standingRegular: [Regular]?
    
    var body: some View {
        ForEach(standingRegular ?? .init()) { team in
            RowStanding(
                content:
                    [
                        (text: team.teamName, width: .infinity),
                        (text: "\(team.wins)", width: 30),
                        (text: "\(team.losses)", width: 30),
                        (text: team.percent, width: 45),
                        (text: team.gb, width: 35),
                        (text: team.pts, width: 45)
                    ])
        }
    }
}

struct StandingRegularView_Previews: PreviewProvider {
    static var previews: some View {
        StandingRegularView(standingRegular: Constats.shared.standingLMP.response.first)
    }
}
