//
//  LeadersPitching.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 06/06/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI
import URLImage

struct LeadersPitchingView: View {
    
    @ObservedObject var viewModel = ViewModel()
    @State private var showActionSheet = false
    
    var body: some View {
        VStack {
            Button(action: {
                self.showActionSheet.toggle()
            }) {
                HStack {
                    Text(viewModel.pitchingType.capitalized)
                    Image(systemName: "chevron.down")
                }
                .foregroundColor(Color(.systemBlue))
                .padding(3)
            }.buttonStyle(PlainButtonStyle())
             .actionSheet(isPresented: $showActionSheet) {
                     ActionSheet(title: Text(""), buttons: [
                         .default(Text("Regular")){
                            self.viewModel.pitchingType = "regular"
                            self.viewModel.pickerPitchingValue = 0
                            self.viewModel.parseLeadersPitching(mode: "pitching", type: "regular", column: "era")
                         },
                         .default(Text("Playoffs")){
                            self.viewModel.pitchingType = "playoffs"
                            self.viewModel.pickerPitchingValue = 0
                            self.viewModel.parseLeadersPitching(mode: "pitching", type: "playoffs", column: "era")
                         },
                         .cancel()])
             }
            Picker(selection: $viewModel.pickerPitchingValue, label: Text("")) {
                Text("ERA").tag(0)
                Text("W").tag(1)
                Text("SO").tag(2)
                Text("SV").tag(3)
                Text("WHIP").tag(4)
            }.pickerStyle(SegmentedPickerStyle())
             .padding(.bottom)
            ForEach(self.viewModel.statisticsListPitching) { item in
                pitchingView(leader: item, bottomValue: self.$viewModel.pickerPitchingValue)
            }
        }
        .frame(height: 640, alignment: .top)
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}

struct LeadersPitching_Previews: PreviewProvider {
    static var previews: some View {
        LeadersPitchingView()
    }
}

struct pitchingView: View {
    
    var leader: leadersPitching
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


