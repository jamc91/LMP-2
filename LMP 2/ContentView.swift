//
//  ContentView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 04/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI
import URLImage

struct ContentView: View {
    
   init() {
        URLImageService.shared.cleanFileCache()
        UITableViewCell.appearance().backgroundColor = UIColor(red: 243/255, green: 242/255, blue: 248/255, alpha: 0)
        UITableView.appearance().separatorStyle = .none

    }
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
                List {
                    HeaderView(viewModel: self.viewModel)
                    Section(header: HeaderSection(sectionName: "Marcadores")) {
                        
                        ScoreBoardView(scoreBoardData: self.viewModel)
                            
                    }
                    Section(header: HeaderSection(sectionName: "Posiciones")) {
                        
                        StandingView(standingData: self.viewModel)
                            
                    }
                    Section(header: HeaderSection(sectionName: "Líderes de bateo")) {
                        
                        LeadersBattingView(viewModel: self.viewModel)
                            
                    }
                    Section(header: HeaderSection(sectionName: "Líderes de Pitcheo")) {
                        
                        LeadersPitchingView(viewModel: self.viewModel)
                            
                    }

                }
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .compact)
                .onAppear(perform: self.viewModel.loadContent)
            
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

struct HeaderView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        HStack (alignment: .bottom){
            Text("Resumen")
                .font(Font.largeTitle)
                .bold()
            Spacer()
            Button(action: {
                self.viewModel.showPickerView.toggle()
            }) {
                Image(systemName: "calendar.circle")
                    .font(.system(size: 35))
                    .foregroundColor(.primary)
                    .frame(width: 35, height: 50, alignment: .center)
            }.buttonStyle(PlainButtonStyle())
        }
    }
}
