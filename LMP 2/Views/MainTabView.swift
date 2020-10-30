//
//  GeneralTabView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 16/08/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        TabView {
            MainScrollView(content: {
                ScoreBoardView(viewModel: viewModel)
            })
            .tabItem {
                TabItemView(title: "Scoreboard", imageName: "doc.richtext.fill")
            }
            MainScrollView {
                StandingView(viewModel: viewModel)
            }
            .tabItem {
                TabItemView(title: "Standings", imageName: "flag.fill")
            }
        }
    }
}

struct TopHeaderView: View {
    
    @ObservedObject var viewModel: ViewModel
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
                    viewModel.didTapCalendarButton()
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
