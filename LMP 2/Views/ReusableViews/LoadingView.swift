//
//  LoadingView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 30/12/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            ProgressView() {
                Text("LOADING")
                    .font(.caption)
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
