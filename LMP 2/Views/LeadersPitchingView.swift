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
    @State private var pickerValue = 0
    @State private var showActionSheet = false
    @State private var buttonText = "Regular"
    
    var body: some View {
        VStack {
            Button(action: {
                self.showActionSheet.toggle()
            }) {
                HStack {
                    Text(buttonText)
                    Image(systemName: "chevron.down")
                }
                .foregroundColor(Color(.systemBlue))
                .padding(3)
            }.buttonStyle(PlainButtonStyle())
             .actionSheet(isPresented: $showActionSheet) {
                     ActionSheet(title: Text(""), buttons: [
                         .default(Text("Regular")){
                             self.viewModel.parseLeadersPitching(mode: "pitching", type: "regular")
                             self.buttonText = "Regular"
                             self.pickerValue = 0
                         },
                         .default(Text("Playoffs")){
                             self.viewModel.parseLeadersPitching(mode: "pitching", type: "playoffs")
                             self.buttonText = "Playoffs"
                             self.pickerValue = 0
                         },
                         .cancel()])
             }
            Picker(selection: $pickerValue, label: Text("")) {
                Text("ERA").tag(0)
                Text("W").tag(1)
                Text("SO").tag(2)
                Text("SV").tag(3)
                Text("WHIP").tag(4)
            }.pickerStyle(SegmentedPickerStyle())
             .padding(.bottom)
            ForEach(self.viewModel.statisticsListPitching.sorted(by: { (s1, s2) -> Bool in
                switch pickerValue {
                case 1:
                    return s1.w.localizedStandardCompare(s2.w) == .orderedDescending
                case 2:
                    return s1.so.localizedStandardCompare(s2.so) == .orderedDescending
                case 3:
                    return s1.sv.localizedStandardCompare(s2.sv) == .orderedDescending
                case 4:
                    return s1.whip.localizedStandardCompare(s2.whip) == .orderedAscending
                default:
                    return s1.era.localizedStandardCompare(s2.era) == .orderedAscending
                }
                
            })) { item in
                pitchingView(leader: item, bottomValue: self.$pickerValue)
            }
        }
        .frame(height: 640, alignment: .top)
        .padding()
        .background(Color("BackgroundCell"))
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
                URLImage(leader.img, expireAfter: Date(timeIntervalSinceNow: 31_556_926.0),processors: [ Resize(size: CGSize(width: 35, height: 35), scale: UIScreen.main.scale)], placeholder: Image(systemName: "person.crop.circle"),
                content:  {
                    $0.image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                })
                .frame(width: 35, height: 35)
                
                VStack (alignment: .leading) {
                    Text(leader.name)
                        .modifier(textModifier(font: .body, fontColor: .primary, fontDesing: .default))
                    Text(leader.team)
                        .modifier(textModifier(font: .footnote, fontColor: .secondary, fontDesing: .default))
                }
                Spacer()
                changeValue(bottomValue: bottomValue)
                
            }
            Divider()
        }
    }
    func changeValue(bottomValue: Int) -> some View {
        switch bottomValue {
        case 1:
            return Text(leader.w)
                .modifier(textModifier(font: .body, fontColor: .primary, fontDesing: .default))
        case 2:
            return Text(leader.so)
                .modifier(textModifier(font: .body, fontColor: .primary, fontDesing: .default))
        case 3:
            return Text(leader.sv)
                .modifier(textModifier(font: .body, fontColor: .primary, fontDesing: .default))
        case 4:
            return Text(leader.whip)
                .modifier(textModifier(font: .body, fontColor: .primary, fontDesing: .default))
        default:
            return Text(leader.era)
                .modifier(textModifier(font: .body, fontColor: .primary, fontDesing: .default))
        }
    }
}


