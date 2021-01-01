//
//  MainScrollView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 25/10/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct MainScrollView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all)
            ScrollView (showsIndicators: false) {
                content
            }
        }
        .padding(.top, 1)
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.top))
    }
}
