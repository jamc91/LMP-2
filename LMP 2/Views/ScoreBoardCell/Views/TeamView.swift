//
//  TeamView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 27/09/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct TeamView: View {
    
    var teamName: String
    var wins, losses: Int
    
    var body: some View {
        VStack {
            Image(teamName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50, alignment: .center)
            Text("(\(wins)-\(losses))")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView(teamName: "140", wins: 0, losses: 0).previewLayout(.sizeThatFits)
    }
}
