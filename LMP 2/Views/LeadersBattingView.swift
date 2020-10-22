//
//  LeadersBatting.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 01/06/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct LeadersBattingView: View {
    
    @ObservedObject var viewModel = ViewModel()
    @State private var showActionSheet = false
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all)
            ScrollView (showsIndicators: false) {
                VStack (spacing: 10) {
                    TopHeaderView(title: "Stats", showCalendarButton: false)
        VStack {
            Button(action: {
                self.showActionSheet = true
            }) {
                HStack {
                    Text(viewModel.requestLeadersOfBattingValue.season.rawValue.capitalized)
                    Image(systemName: "chevron.down")
                }.foregroundColor(Color(.systemBlue))
                    .padding(3)
            }.buttonStyle(PlainButtonStyle())
                .actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(title: Text(""), buttons: [
                        .default(Text("Regular")){
                            self.viewModel.requestLeadersOfBattingValue.season = .regular
                        },
                        .default(Text("Playoffs")){
                            self.viewModel.requestLeadersOfBattingValue.season = .playoffs
                        },
                        .cancel()])
            }
            Picker(selection: $viewModel.requestLeadersOfBattingValue.category, label: Text("")) {
                Text("AVG").tag(leadersBatting.battingCategory.avg)
                Text("R").tag(leadersBatting.battingCategory.r)
                Text("HR").tag(leadersBatting.battingCategory.hr)
                Text("RBI").tag(leadersBatting.battingCategory.rbi)
                Text("SB").tag(leadersBatting.battingCategory.sb)
            }.pickerStyle(SegmentedPickerStyle())
                .padding(.bottom)
            
            ForEach(self.viewModel.leadersOfBattingList) { item in
                battingView(leader: item, bottomValue: self.$viewModel.requestLeadersOfBattingValue.category)
            }
        }
        .frame(height: 640, alignment: .top)
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
                }
                .animation(.default)
                .padding(.horizontal, 20)
            }.background(Color(.systemGroupedBackground))
        }.navigationBarHidden(true)
    }
}

struct LeadersBatting_Previews: PreviewProvider {
    static var previews: some View {
        
        LeadersBattingView(viewModel: ViewModel())
        
    }
}

struct battingView: View {
    
    var leader: leadersBatting
    @Binding var bottomValue: leadersBatting.battingCategory
    
    var body: some View {
        VStack {
            HStack {
                WebImage(url: leader.thumb)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 35, height: 35, alignment: .center)
                VStack (alignment: .leading) {
                    Text(leader.name)
                        .modifier(textModifier(font: .body, fontColor: .primary, fontDesing: .default))
                    Text(leader.team)
                        .modifier(textModifier(font: .footnote, fontColor: .secondary, fontDesing: .default))
                }
                Spacer()
                Text(leader.getValue(picker: bottomValue))
                    .modifier(textModifier(font: .body, fontColor: .primary, fontDesing: .default))
            }
            Divider()
        }
    }
}
