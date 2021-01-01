//
//  ScoreView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 27/09/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct ScoreView: View {
    
    let awayScore, homeScore: Int
    let status: String
    
    var body: some View {
        VStack {
            Text("\(awayScore)-\(homeScore)")
                .font(.system(size: 45, weight: .semibold, design: .rounded))
                .foregroundColor(.primary)
            Text(status)
                .font(.headline)
                .foregroundColor(.secondary)
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScoreView(awayScore: 2, homeScore: 3, status: "Final").previewLayout(.sizeThatFits)
            ScoreView(awayScore: 2, homeScore: 3, status: "Final").previewLayout(.sizeThatFits).preferredColorScheme(.dark)
        }
    }
}
