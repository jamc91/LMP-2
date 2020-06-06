//
//  StatisticsView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 01/06/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct StatisticsView: View {
    
    @ObservedObject var viewModel = ViewModel()
    @State private var pickerTopValue = "regular"
    @State private var pickerBottomValue = "avg"
    
    var body: some View {
        
        VStack {
            Picker(selection: $pickerTopValue, label: Text("")) {
                Text("Regular").tag("regular")
                Text("Playoffs").tag("playoffs")
            }.pickerStyle(SegmentedPickerStyle())
            Picker(selection: $pickerBottomValue, label: Text("")) {
                Text("AVG").tag("avg")
                Text("R").tag("r")
                Text("HR").tag("hr")
                Text("RBI").tag("rbi")
                Text("SB").tag("sb")
            }.pickerStyle(SegmentedPickerStyle())
             .padding(.bottom)
            viewShow()
        }
        .padding()
        .background(Color("BackgroundCell"))
        .cornerRadius(10)
    }
    
    func viewShow() -> some View {
        
        self.viewModel.parseStatisticsRegular(mode: "batting", type: self.pickerTopValue, column: self.pickerBottomValue)
        
        switch pickerBottomValue {
        case "avg":
            return ForEach(self.viewModel.statisticsListRegular, id: \.milb_id) { item in
            leaderView(name: item.name, team: item.team, value: item.avg)
            }
        case "r":
            return ForEach(self.viewModel.statisticsListRegular, id: \.milb_id) { item in
            leaderView(name: item.name, team: item.team, value: item.r)
            }
        case "hr":
            return ForEach(self.viewModel.statisticsListRegular, id: \.milb_id) { item in
            leaderView(name: item.name, team: item.team, value: item.hr)
            }
        case "rbi":
            return ForEach(self.viewModel.statisticsListRegular, id: \.milb_id) { item in
            leaderView(name: item.name, team: item.team, value: item.rbi)
            }
        case "sb":
            return ForEach(self.viewModel.statisticsListRegular, id: \.milb_id) { item in
            leaderView(name: item.name, team: item.team, value: item.sb)
            }
        default:
            return ForEach(self.viewModel.statisticsListRegular, id: \.milb_id) { item in
            leaderView(name: item.name, team: item.team, value: item.avg)
            }
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        
        StatisticsView()
        
    }
}

struct leaderView: View {
    
    var name, team, value: String?
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 35, height: 35)
                VStack (alignment: .leading) {
                    Text(name!)
                        .modifier(textModifier(font: .body, fontColor: .primary, fontDesing: .default))
                    Text(team!)
                        .modifier(textModifier(font: .footnote, fontColor: .secondary, fontDesing: .default))
                }
                Spacer()
                Text(value!)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.primary)
                
            }
            Divider()
        }
    }
}

struct leaderPlayoffsView: View {
    
   var name, team, value: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 35, height: 35)
                VStack (alignment: .leading) {
                    Text(name)
                        .modifier(textModifier(font: .body, fontColor: .primary, fontDesing: .default))
                    Text(team)
                        .modifier(textModifier(font: .footnote, fontColor: .secondary, fontDesing: .default))
                }
                Spacer()
                Text(value)
                    .modifier(textModifier(font: .headline, fontColor: .primary, fontDesing: .default))
                
            }
            Divider()
        }
    }
}



