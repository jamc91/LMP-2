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
    
    @ObservedObject var results = RowViewModel()

    
    var body: some View {
        
        ZStack {
            NavigationView {
                    List {
                        Section(header: HeaderSection(sectionName: "ScoreBoard")) {
                            
                                ScoreBoardView(scoreBoardData: results)
                            
                        }
                        Section(header: HeaderSection(sectionName: "Standings")) {
                            
                                StandingView(standingData: self.results)
                        }
                        Section(header: HeaderSection(sectionName: "Lideres de bateo")) {
                            StatisticsView(statisticsData: self.results)
                            
                        }
                    }
                    .navigationBarTitle("Resumen")
                    .navigationBarItems(trailing: Button(action: {
                            self.results.showPickerView.toggle()
                        }){
                            Image(systemName: "ellipsis.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(.primary)
                                .padding(.leading)
                    })
                        .listStyle(GroupedListStyle())
                        .environment(\.horizontalSizeClass, .compact)
                        .onAppear(perform: self.results.parseStandings)
                        .onAppear(perform: self.results.parseData)
                        .onAppear(perform: self.results.parseStatisticsRegular)
                        .onAppear(perform: self.results.parseStatisticsPlayoffs)
            }
            VStack {
                Spacer()
                
                PickerView(data: results).offset(y: self.results.showPickerView ? 0 : UIScreen.main.bounds.height)
                
                
                
            }
            .background((self.results.showPickerView ? Color.black.opacity(0.5) : Color.clear)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                self.results.showPickerView = false
            })
                .edgesIgnoringSafeArea(.bottom)
                .animation(.spring())
                .zIndex(1)
            VStack {
                Spacer()
                selectorStandingView(standingData: results).offset(y: self.results.showSelector ? 0 : UIScreen.main.bounds.height)
                
            }
            .background((self.results.showSelector ? Color.black.opacity(0.5) : Color.clear)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                self.results.showSelector = false
            })
                .edgesIgnoringSafeArea(.bottom)
                .animation(.spring())
            .zIndex(2)
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
