//
//  TeamNameBoxscoreView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 18/10/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct TeamNameBoxscoreView: View {
    
    var awayName, homeName: String
    
    var body: some View {
        VStack (alignment: .leading) {
            Group {
                Text("TEAM")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(awayName)
                    .bold()
                Text(homeName)
                    .bold()
            }
            .font(.caption)
            
        }.frame(width: 80, alignment: .leading)
    }
}

struct TeamNameBoxscoreView_Previews: PreviewProvider {
    static var previews: some View {
        TeamNameBoxscoreView(awayName: "Navojoa", homeName: "Hermosillo")
    }
}
