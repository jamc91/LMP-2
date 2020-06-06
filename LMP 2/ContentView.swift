//
//  ContentView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 04/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        
        UITableViewCell.appearance().backgroundColor = UIColor(red: 243/255, green: 242/255, blue: 248/255, alpha: 0)
        UITableView.appearance().separatorStyle = .none

    }
    
    @ObservedObject var viewModel = ViewModel()
    

    var body: some View {
        ZStack {
            NavigationView {
                List {
                    Section(header: HeaderSection(sectionName: "ScoreBoard")) {
                        
                        ScoreBoardView(scoreBoardData: viewModel)
                        
                    }
                    Section(header: HeaderSection(sectionName: "Standings")) {
                        
                        StandingView(standingData: self.viewModel)
                        
                    }
                    Section(header: HeaderSection(sectionName: "Lideres de bateo")) {
                        
                        StatisticsView(viewModel: self.viewModel)
                        
                    }
                }
                .navigationBarTitle("Resumen")
                .navigationBarItems(trailing: Button(action: {
                    self.viewModel.showPickerView.toggle()
                }){
                    Image(systemName: "ellipsis.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.primary)
                        .padding(.leading)
                })
                    .listStyle(GroupedListStyle())
                    .environment(\.horizontalSizeClass, .compact)
                    .onAppear(perform: self.viewModel.loadContent)
            }
            VStack {
                Spacer()
                
                PickerView(viewModel: viewModel)
                    .offset(y: self.viewModel.showPickerView ? 0 : UIScreen.main.bounds.height)
                
            }
            .background((self.viewModel.showPickerView ? Color.black.opacity(0.5) : Color.clear)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                self.viewModel.showPickerView = false
            })
                .edgesIgnoringSafeArea(.bottom)
                .animation(.spring())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}

struct HeaderSection: View {
    
    var sectionName = ""
    
    var body: some View {
        Text(sectionName).font(.system(size: 22)).bold().foregroundColor(.primary)
    }
}
