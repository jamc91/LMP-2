//
//  ListView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 15/07/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        List {
            VStack (alignment: .leading, spacing: 10) {
                HeaderView(viewModel: viewModel)
                Section(header: HeaderSection(sectionName: "Marcadores")) {
                    
                    ScoreBoardView(viewModel: viewModel)
                    
                }
                Section(header: HeaderSection(sectionName: "Posiciones")) {
                    
                    StandingView(viewModel: viewModel)
                        
                }
                Section(header: HeaderSection(sectionName: "Líderes de bateo")) {
                    
                    LeadersBattingView(viewModel: viewModel)
                    
                }
                Section(header: HeaderSection(sectionName: "Líderes de Pitcheo")) {
                    
                    LeadersPitchingView(viewModel: viewModel)
                    
                }
            }.animation(.spring())
        }
        .listStyle(GroupedListStyle())
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

struct HeaderSection: View {
    
    var sectionName = ""
    
    var body: some View {
        
        HStack {
            Text(sectionName).font(.system(size: 22)).bold().foregroundColor(.primary)
        }.padding(.top)
    }
}
