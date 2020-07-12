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
                    Text(viewModel.requestLeadersOfPitchingValue.season.rawValue.capitalized)
                    Image(systemName: "chevron.down")
                }
                .foregroundColor(Color(.systemBlue))
                .padding(3)
            }.buttonStyle(PlainButtonStyle())
             .actionSheet(isPresented: $showActionSheet) {
                     ActionSheet(title: Text(""), buttons: [
                         .default(Text("Regular")){
                            self.viewModel.requestLeadersOfPitchingValue.season = .regular
                         },
                         .default(Text("Playoffs")){
                            self.viewModel.requestLeadersOfPitchingValue.season = .playoffs
                         },
                         .cancel()])
             }
            Picker(selection: $viewModel.requestLeadersOfPitchingValue.category, label: Text("")) {
                Text("ERA").tag(leadersPitching.pitchingCategory.era)
                Text("W").tag(leadersPitching.pitchingCategory.w)
                Text("SO").tag(leadersPitching.pitchingCategory.so)
                Text("SV").tag(leadersPitching.pitchingCategory.sv)
                Text("WHIP").tag(leadersPitching.pitchingCategory.whip)
            }.pickerStyle(SegmentedPickerStyle())
             .padding(.bottom)
            ForEach(self.viewModel.leadersOfPitchingList) { item in
                pitchingView(leader: item, bottomValue: self.$viewModel.requestLeadersOfPitchingValue.category)
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
    @Binding var bottomValue: leadersPitching.pitchingCategory
    
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


