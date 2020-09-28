//
//  TabViewTest.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 16/08/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct GeneralTabView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView {
                ScoreBoardView(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: "doc.richtext.fill")
                            .imageScale(.large)
                        Text("ScoreBoads")
                    }
                StandingView(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: "flag.fill")
                            .imageScale(.large)
                        Text("Standings")
                    }
                LeadersBattingView(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: "chart.bar.xaxis")
                            .imageScale(.large)
                        Text("Stats")
                    }
                SettingsView()
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                            .imageScale(.large)
                        Text("Settings")
                    }
            }
            .padding(.bottom)
            .edgesIgnoringSafeArea(.bottom)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .blur(radius: viewModel.showPickerView ? 10.0 : 0.0).animation(.spring(response: 0.3, dampingFraction: 1.0, blendDuration: 0.3))
        
    }
}

struct TopHeaderView: View {
    
    @ObservedObject var viewModel = ViewModel()
    var title: String
    var showCalendarButton: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.bold)
                .font(.largeTitle)
            Spacer()
            if showCalendarButton {
                Button(action: {
                    self.viewModel.showPickerView = true
                    self.viewModel.timer.invalidate()
                }) {
                    Image(systemName: "calendar.circle.fill")
                        .font(.system(size: 35))
                        .foregroundColor(.primary)
                }
            }
        }
        .padding(.top, 50)
    }
}

/*struct CustomTabView: View {
    
    @ObservedObject var viewModel = ViewModel()
    @State private var selectedTab = "doc.richtext.fill"
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
            NavigationView {
                TabView (selection: $selectedTab) {
                    ScoreBoardView(viewModel: viewModel).tag("doc.richtext.fill")
                    StandingView(viewModel: viewModel).tag("flag.fill")
                    LeadersBattingView(viewModel: viewModel).tag("chart.bar.xaxis")
                    SettingsView().tag("gearshape.fill")
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .navigationBarHidden(true)
                
            }
            VStack (spacing: 0) {
                Divider()
                HStack {
                    ForEach(tabs, id: \.self) { image in
                        TabButton(image: image, selectedBar: $selectedTab)
                        if image != tabs.last {
                            Spacer(minLength: 0)
                        }
                    }
                }
            }
            .background(Color(.secondarySystemGroupedBackground)
                            .edgesIgnoringSafeArea(.all))
            
        }.animation(.spring())
    }
}

struct TabViewTest_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
    }
}

var tabs = ["doc.richtext.fill", "flag.fill", "chart.bar.xaxis", "gearshape.fill"]

struct TabButton: View {
    
    var image: String
    @Binding var selectedBar: String
    
    var body: some View {
        Button(action: {
            selectedBar = image
        }){
            Image(systemName: image)
                .imageScale(.large)
                .foregroundColor(selectedBar == image ? Color(.systemBlue) : Color.secondary)
                .padding()
                .padding(.horizontal)
        }
    }
}*/

struct SettingsView: View {
    var body: some View {
        Text("Settings")
    }
}
