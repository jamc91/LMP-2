//
//  InningView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 04/10/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct InningView: View {
    
    let arrowStatus: String
    let currentInning: String
    
    var body: some View {
        HStack {
            Image(systemName: arrowStatus)
                .foregroundColor(Color("ActiveColor"))
            Text(currentInning)
        }
        .font(.title2)
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
