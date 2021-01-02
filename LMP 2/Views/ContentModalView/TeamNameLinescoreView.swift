//
//  TeamNameLinescoreView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 01/01/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct TeamNameLinescoreView: View {
    
    let awayTeamName: String
    let homeTeamName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(awayTeamName).bold()
            Text(homeTeamName).bold()
        }
        .font(.caption)
        .padding(.leading, 10)
    }
}

struct TeamNameLinescoreView_Previews: PreviewProvider {
    static var previews: some View {
        TeamNameLinescoreView(awayTeamName: "Mayos", homeTeamName: "Naranjeros").previewLayout(.sizeThatFits)
    }
}
