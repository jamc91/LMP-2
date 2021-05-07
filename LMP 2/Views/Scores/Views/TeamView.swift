//
//  TeamView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 27/09/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct TeamView: View {
    
    let teamName: String
    let wins, losses: Int
    
    var body: some View {
        VStack {
            Image(teamName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50, alignment: .center)
            Text("(\(wins)-\(losses))")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal)
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TeamView(teamName: "140", wins: 0, losses: 0).previewLayout(.sizeThatFits)
            TeamView(teamName: "140", wins: 0, losses: 0).previewLayout(.sizeThatFits).preferredColorScheme(.dark)
        }
    }
}
