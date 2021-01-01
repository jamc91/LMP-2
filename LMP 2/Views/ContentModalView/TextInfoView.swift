//
//  TextInfoView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 12/3/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct TextInfoView: View {
    
    var label: String
    var value: String
    
    var body: some View {
        Group {
            Text("\(label): ").bold() + Text(value)
        }
        .font(.caption)
    }
}

struct TextInfoView_Previews: PreviewProvider {
    static var previews: some View {
        TextInfoView(label: "Corredores dejados en circulacion, 2 out", value: "d'Arnaud; Swanson; Ozuna; Riley, A.").previewLayout(.sizeThatFits)
    }
}
