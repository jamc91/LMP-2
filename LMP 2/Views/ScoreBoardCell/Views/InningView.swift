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
        HStack (spacing: 10) {
            Image(systemName: arrowStatus)
                .foregroundColor(Color("ActiveColor"))
                .font(.title2)
            Text(currentInning)
                .foregroundColor(Color("LightGray"))
                .font(.title2)
        }.frame(width: 100, height: 100, alignment: .center)
    }
}


struct InningView_Previews: PreviewProvider {
    static var previews: some View {
        InningView(arrowStatus: "arrowtriangle.up.fill", currentInning: "1st").previewLayout(.sizeThatFits)
    }
}
