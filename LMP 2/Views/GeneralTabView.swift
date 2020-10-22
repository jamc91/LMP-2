//
//  GeneralTabView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 16/08/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct GeneralTabView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        TabView {
            ScoreBoardView(viewModel: viewModel)
                .tabItem {
                    TabItemView(title: "Scores", imageName: "doc.richtext.fill")
                }
            StandingView(viewModel: viewModel)
                .tabItem {
                    TabItemView(title: "Standings", imageName: "flag.fill")
                }
            LeadersBattingView(viewModel: viewModel)
                .tabItem {
                    TabItemView(title: "Stats", imageName: "chart.bar.xaxis")
            }
        }
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
                    self.viewModel.timerStatus(state: true)
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

struct TabItemView: View {
    
    var title: String
    var imageName: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .imageScale(.large)
            Text(title)
        }
    }
}
