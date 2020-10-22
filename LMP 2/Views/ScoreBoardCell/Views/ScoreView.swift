//
//  ScoreView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 27/09/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct ScoreView: View {
    
    var awayScore, homeScore: Int
    var status: String
    
    var body: some View {
        VStack {
            Text("\(awayScore)-\(homeScore)")
                .font(.system(size: 45))
                .bold()
                .foregroundColor(.primary)
            Text(status)
                .font(.title2)
                .foregroundColor(.primary)
        }.frame(maxWidth: .infinity, minHeight: 100)
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(awayScore: 2, homeScore: 3, status: "Final").previewLayout(.sizeThatFits)
    }
}
