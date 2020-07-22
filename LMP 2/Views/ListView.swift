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
        NavigationView {
        List {
            VStack {
                Section(header: HeaderSection(sectionName: "Marcadores")) {
                    
                    EquatableView(content: ScoreBoardView(viewModel: viewModel))
                    
                }
            /*    Section(header: HeaderSection(sectionName: "Posiciones")) {
                    
                    StandingView(viewModel: viewModel)
                        
                }*/
                Section(header: HeaderSection(sectionName: "Líderes de bateo")) {
                    
                    LeadersBattingView(viewModel: viewModel)
                    
                }
                Section(header: HeaderSection(sectionName: "Líderes de Pitcheo")) {
                    
                    LeadersPitchingView(viewModel: viewModel)
                    
                }
            }
            .animation(.spring())
            .listRowBackground(Color(.systemGroupedBackground))
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Resumen")
        .navigationBarItems(trailing: Button(action: {
            self.viewModel.timer.invalidate()
            self.viewModel.showPickerView.toggle()
        }) {
            Image(systemName: "calendar.circle.fill")
                .font(.system(size: 35))
                .foregroundColor(.primary)
                .frame(width: 35, height: 50, alignment: .center)
        }.buttonStyle(PlainButtonStyle()))
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

struct HeaderSection: View {
    
    var sectionName: String
    
    var body: some View {
        
        HStack {
            Text(sectionName).font(.system(size: 22)).bold().foregroundColor(.primary)
            Spacer()
        }.padding(.top)
    }
}
