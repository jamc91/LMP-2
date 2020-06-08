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
    @State private var buttonText = "Regular"
    @State private var pickerBottomValue = 0
    @State private var showActionSheet = false

    var body: some View {
        
        VStack {
            Button(action: {
                self.showActionSheet = true
            }) {
                HStack {
                    Text(buttonText)
                    Image(systemName: "chevron.down")
                }.foregroundColor(Color(.systemBlue))
                 .padding(3)
                }.buttonStyle(PlainButtonStyle())
                .actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(title: Text(""), buttons: [
                        .default(Text("Regular")){
                            self.viewModel.parseLeadersBatting(mode: "batting", type: "regular")
                            self.buttonText = "Regular"
                            self.pickerBottomValue = 0
                        },
                        .default(Text("Playoffs")){
                            self.viewModel.parseLeadersBatting(mode: "batting", type: "playoffs")
                            self.buttonText = "Playoffs"
                            self.pickerBottomValue = 0
                        },
                        .cancel()])
            }
            Picker(selection: $pickerBottomValue, label: Text("")) {
                Text("AVG").tag(0)
                Text("R").tag(1)
                Text("HR").tag(2)
                Text("RBI").tag(3)
                Text("SB").tag(4)
            }.pickerStyle(SegmentedPickerStyle())
             .padding(.bottom)
            ForEach(self.viewModel.statisticsListBatting.sorted(by: { (s1, s2) -> Bool in
                switch pickerBottomValue {
                case 1:
                    return s1.r.localizedStandardCompare(s2.r) == .orderedDescending
                case 2:
                    return s1.hr.localizedStandardCompare(s2.hr) == .orderedDescending
                case 3:
                    return s1.rbi.localizedStandardCompare(s2.rbi) == .orderedDescending
                case 4:
                    return s1.sb.localizedStandardCompare(s2.sb) == .orderedDescending
                default:
                    return s1.avg.localizedStandardCompare(s2.avg) == .orderedDescending
                }
                
            })) { item in
                battingView(leader: item, bottomValue: self.$pickerBottomValue)
            }
        }
        .frame(height: 640, alignment: .top)
        .padding()
        .background(Color("BackgroundCell"))
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
                URLImage(leader.img,  expireAfter: Date(timeIntervalSinceNow: 31_556_926.0),processors: [ Resize(size: CGSize(width: 35, height: 35), scale: UIScreen.main.scale) ], placeholder: Image(systemName: "person.crop.circle"),
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
            return Text(leader.r)
                .modifier(textModifier(font: .body, fontColor: .primary, fontDesing: .default))
        case 2:
            return Text(leader.hr)
                .modifier(textModifier(font: .body, fontColor: .primary, fontDesing: .default))
        case 3:
            return Text(leader.rbi)
                .modifier(textModifier(font: .body, fontColor: .primary, fontDesing: .default))
        case 4:
            return Text(leader.sb)
                .modifier(textModifier(font: .body, fontColor: .primary, fontDesing: .default))
        default:
            return Text(leader.avg)
                .modifier(textModifier(font: .body, fontColor: .primary, fontDesing: .default))
        }
    }
}


