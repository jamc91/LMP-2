//
//  ScrollGameView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 30/07/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct ScrollGameView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack (spacing: 10) {
                    TopHeaderView(viewModel: viewModel, title: "ScoreBoards", showButton: true)
                    Section(header: HeaderSectionView(title: "ScoreBoards")) {
                        ScoreBoardView(viewModel: viewModel)
                    }
                    Section(header: HeaderSectionView(title: "Standings")) {
                        StandingView(viewModel: viewModel)
                    }
                    Section(header: HeaderSectionView(title: "Leaders Batting")) {
                        LeadersBattingView(viewModel: viewModel)
                    }
                    Section(header: HeaderSectionView(title: "Leaders Pitching")) {
                        LeadersPitchingView(viewModel: viewModel)
                    }
                }
                .animation(.default)
                .padding(.horizontal, 20)
            }
            .background(Color(.systemGroupedBackground))
        }
    }
}


struct ScrollGameView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollGameView()
    }
}

struct TopHeaderView: View {
    
     @ObservedObject var viewModel = ViewModel()
    var title: String
    var showButton: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.bold)
                .font(.largeTitle)
            Spacer()
            if showButton {
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

struct HeaderSectionView: View {
    
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.bold)
                .font(.system(size: 22))
            Spacer()
        }.padding(.top, 15)
    }
}
