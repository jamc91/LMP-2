//
//  BoxscoreView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 07/10/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct BoxscoreView: View {
    
    
    var totalInnings: Range<Int>
    var runs: [Innings]
    
    var body: some View {
        
        VStack (alignment: .leading) {
            HStack (spacing: 0) {
                ForEach(totalInnings, id: \.self) { item in
                    Text("\(item)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(width: 20, alignment: .center)
                        
                }
            }
            HStack (spacing: 0) {
                ForEach(runs) { run in
                    VStack {
                        Text("\(run.away.runs)")
                            .font(.caption)
                            .fontWeight(run.away.runs > 0 ? .bold : .none)
                        Text("\(run.home.runs)")
                            .font(.caption)
                            .fontWeight(run.home.runs > 0 ? .bold : .none)
                    }.frame(width: 20, alignment: .center)
                }
            }
        }
    }
}

struct BoxscoreView_Previews: PreviewProvider {
    static var previews: some View {
        BoxscoreView(totalInnings: 1..<10, runs: [Innings(), Innings(), Innings(), Innings(), Innings(), Innings(), Innings(), Innings(), Innings()]).previewLayout(.sizeThatFits).padding()
    }
}
