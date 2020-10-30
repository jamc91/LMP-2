//
//  RHETextView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 18/10/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct RHETextView: View {
    
    let topText = ["R", "H", "E"]
    var awayRuns, awayHits, awayErrors: Int
    var homeRuns, homeHits, homeErrors: Int
    
    var body: some View {
        VStack {
            HStack (spacing: 0) {
                ForEach(topText, id: \.self) { item in
                    Text(item)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(width: 20, alignment: .center)
                }
            }
            TeamRHEInfoView(runs: awayRuns, hits: awayHits, errors: awayErrors)
            TeamRHEInfoView(runs: homeRuns, hits: homeHits, errors: homeErrors)
        }
    }
}

struct RHETextView_Previews: PreviewProvider {
    static var previews: some View {
        RHETextView(awayRuns: 0, awayHits: 0, awayErrors: 0, homeRuns: 0, homeHits: 0, homeErrors: 0)
    }
}

struct TeamRHEInfoView: View {
    
    var runs: Int
    var hits: Int
    var errors: Int
    
    var body: some View {
        HStack (spacing: 0) {
            Group {
                Text("\(runs)")
                    .font(.caption)
                    .fontWeight(runs > 0 ? .bold : .none)
                Text("\(hits)")
                    .font(.caption)
                    .fontWeight(hits > 0 ? .bold : .none)
                Text("\(errors)")
                    .font(.caption)
                    .fontWeight(errors > 0 ? .bold : .none)
            }.frame(width: 20, alignment: .center)
        }
    }
}
