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
    
    @ObservedObject var viewModel = ViewModel()
    
    
    var body: some View {
        if viewModel.showMainActivityIndicator {
            return HStack (alignment: .center) {
                ActivityIndicator(showIndicator: $viewModel.showMainActivityIndicator, style: .medium)
                .onAppear(perform: self.viewModel.loadContent)
                Text("Cargando")
                    .foregroundColor(.secondary)
            }
        .eraseToAnyView()
        } else {
        return ZStack {
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
            .animation(nil)
            .listStyle(GroupedListStyle())
            
            
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
                .edgesIgnoringSafeArea(.all)
                .animation(.spring())
        }
        .eraseToAnyView()
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
        
        HStack {
            Text(sectionName).font(.system(size: 22)).bold().foregroundColor(.primary)
        }.padding(.top)
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
                Image(systemName: "calendar.circle.fill")
                    .font(.system(size: 35))
                    .foregroundColor(.primary)
                    .frame(width: 35, height: 50, alignment: .center)
            }.buttonStyle(PlainButtonStyle())
        }
    }
}
