//
//  InningView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 04/10/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct InningView: View {
    
    var arrowStatus: String
    var currentInning: String
    
    var body: some View {
        HStack {
            Image(systemName: arrowStatus)
                .foregroundColor(Color("ActiveColor"))
                .font(.title2)
            Text(currentInning)
                .foregroundColor(.secondary)
                .font(.title2)
        }.frame(width: 100, height: 100)
    }
}

struct InningView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InningView(arrowStatus: "arrowtriangle.up.fill", currentInning: "1st").previewLayout(.sizeThatFits)
            InningView(arrowStatus: "arrowtriangle.down.fill", currentInning: "1st").previewLayout(.sizeThatFits).preferredColorScheme(.dark)
        }
    }
}
