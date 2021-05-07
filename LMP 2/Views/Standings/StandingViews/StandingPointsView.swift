//
//  StandingPointsView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 05/05/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct StandingPointsView: View {
    
    let standingRegular: [Points]?
    
    var body: some View {
        ForEach(standingRegular ?? .init()) { team in
            RowStanding(
                content:
                    [
                        (text: team.teamName, width: .infinity),
                        (text: "\(team.first)", width: 40),
                        (text: "\(team.second)", width: 40),
                        (text: team.total, width: 45),
                    ])
        }
    }
}

struct StandingPointsView_Previews: PreviewProvider {
    static var previews: some View {
        StandingPointsView(standingRegular: Constats.shared.standingLMP.response.points)
    }
}
