//
//  ProbablePitcherView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 01/11/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct ProbablePitcherView: View {
    
    var player1: People
    var player2: People
    
    var body: some View {
        HStack {
            PersonView(imageID: player1.id, personName: player1.boxscoreName, primaryNumber: player1.primaryNumber, pitchHand: player1.pitchHand.code, stats: player1.playerPitchingStats, position: .left)
            Spacer()
            PersonView(imageID: player2.id, personName: player2.boxscoreName, primaryNumber: player2.primaryNumber, pitchHand: player2.pitchHand.code, stats: player2.playerPitchingStats, position: .right)
        }
        .padding()
    }
}
