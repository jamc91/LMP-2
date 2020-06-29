//
//  LeadersBatting.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 01/06/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI
import URLImage

struct LeadersBattingView: View {
    
    @ObservedObject var viewModel = ViewModel()
    @State private var showActionSheet = false

    var body: some View {
        
        VStack {
            Button(action: {
                self.showActionSheet = true
            }) {
                HStack {
                    Text(viewModel.battingType.capitalized)
                    Image(systemName: "chevron.down")
                }.foregroundColor(Color(.systemBlue))
                 .padding(3)
                }.buttonStyle(PlainButtonStyle())
                .actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(title: Text(""), buttons: [
                        .default(Text("Regular")){
                            self.viewModel.battingType = "regular"
                            self.viewModel.pickerBattingValue = 0
                            self.viewModel.parseLeadersBatting(mode: "batting", type: "regular", column: "avg")
                        },
                        .default(Text("Playoffs")){
                            self.viewModel.battingType = "playoffs"
                            self.viewModel.pickerBattingValue = 0
                            self.viewModel.parseLeadersBatting(mode: "batting", type: "playoffs", column: "avg")
                        },
                        .cancel()])
            }
            Picker(selection: $viewModel.pickerBattingValue, label: Text("")) {
                Text("AVG").tag(0)
                Text("R").tag(1)
                Text("HR").tag(2)
                Text("RBI").tag(3)
                Text("SB").tag(4)
            }.pickerStyle(SegmentedPickerStyle())
             .padding(.bottom)
            ForEach(self.viewModel.statisticsListBatting) { item in
                battingView(leader: item, bottomValue: self.$viewModel.pickerBattingValue)
            }
        }
        .frame(height: 640, alignment: .top)
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
    
}

struct LeadersBatting_Previews: PreviewProvider {
    static var previews: some View {
        
        LeadersBattingView(viewModel: ViewModel())
        
    }
}

struct battingView: View {
    
    var leader: leadersBatting
    @Binding var bottomValue: Int
    
    var body: some View {
        VStack {
            HStack {
                URLImage(leader.thumb,
                         placeholder: Image(systemName: "person.crop.circle"),
                         content: {
                    $0.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())                    
                })
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
