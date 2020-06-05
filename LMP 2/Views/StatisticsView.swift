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
    @State private var pickerTopValue = 0
    @State private var pickerBottomValue = 0
    
    var body: some View {
        
        VStack {
            Picker(selection: $pickerTopValue, label: Text("")) {
                Text("Regular").tag(0)
                Text("Playoffs").tag(1)
            }.pickerStyle(SegmentedPickerStyle())
            Picker(selection: $pickerBottomValue, label: Text("")) {
                Text("AVG").tag(0)
                Text("R").tag(1)
                Text("HR").tag(2)
                Text("RBI").tag(3)
                Text("SB").tag(4)
            }.pickerStyle(SegmentedPickerStyle())
             .padding(.bottom)
            
            
            typeStastistic(top: pickerTopValue, bottom: pickerBottomValue)
            
        }
        .padding()
        .background(Color("BackgroundCell"))
        .cornerRadius(10)
    }
    
    func typeStastistic(top: Int, bottom: Int) -> some View {
        
        if top == 0 {
        switch bottom {
        case 0:
            return ForEach(viewModel.statisticsListRegular.sorted(by: { (a, b) -> Bool in
                    return a.avg.localizedStandardCompare(b.avg) == .orderedDescending
                }), id: \.milb_id) { item in
                                
                leaderView(leaderData: item)
                    
            }.eraseToAnyView()
            
            case 1:
                return ForEach(viewModel.statisticsListRegular.sorted(by: { (a, b) -> Bool in
                    return a.r.localizedStandardCompare(b.r) == .orderedDescending
                }), id: \.milb_id) { item in
                                
                leaderView(leaderData: item)
                    
            }.eraseToAnyView()
            case 2:
                return ForEach(viewModel.statisticsListRegular.sorted(by: { (a, b) -> Bool in
                        return a.hr.localizedStandardCompare(b.hr) == .orderedDescending
                    }), id: \.milb_id) { item in
                                    
                        leaderView(leaderData: item)
                        
                }.eraseToAnyView()
            case 3:
                return ForEach(viewModel.statisticsListRegular.sorted(by: { (a, b) -> Bool in
                    return a.rbi.localizedStandardCompare(b.rbi) == .orderedDescending
                }), id: \.milb_id) { item in
                                
                leaderView(leaderData: item)
                    
            }.eraseToAnyView()
            case 4:
                return ForEach(viewModel.statisticsListRegular.sorted(by: { (a, b) -> Bool in
                    return a.sb.localizedStandardCompare(b.sb) == .orderedDescending
                }), id: \.milb_id) { item in
                                
                leaderView(leaderData: item)
                    
            }.eraseToAnyView()
        default:
            return ForEach(viewModel.statisticsListRegular, id: \.milb_id) { item in
                                
                leaderView(leaderData: item)
                
            }.eraseToAnyView()
            }
        } else {
            switch bottom {
            case 0:
                return ForEach(viewModel.statisticsListPlayoffs.sorted(by: { (a, b) -> Bool in
                    return a.avg.localizedStandardCompare(b.avg) == .orderedDescending
                }), id: \.milb_id) { item in
                    
                    leaderPlayoffsView(leaderData: item)
                    
                }.eraseToAnyView()
            case 1:
                return ForEach(viewModel.statisticsListPlayoffs.sorted(by: { (a, b) -> Bool in
                    return a.r.localizedStandardCompare(b.r) == .orderedDescending
                }), id: \.milb_id) { item in
                    
                    leaderPlayoffsView(leaderData: item)
                    
                }.eraseToAnyView()
            case 2:
                return ForEach(viewModel.statisticsListPlayoffs.sorted(by: { (s1, s2) -> Bool in
                    return s1.hr.localizedStandardCompare(s2.hr) == .orderedDescending
                }), id: \.milb_id) { item in
                    
                    leaderPlayoffsView(leaderData: item)
                    
                }.eraseToAnyView()
            case 3:
                return ForEach(viewModel.statisticsListPlayoffs.sorted(by: { (a, b) -> Bool in
                    return a.rbi.localizedStandardCompare(b.rbi) == .orderedDescending
                }), id: \.milb_id) { item in
                    
                    leaderPlayoffsView(leaderData: item)
                    
                }.eraseToAnyView()
            case 4:
                return ForEach(viewModel.statisticsListPlayoffs.sorted(by: { (a, b) -> Bool in
                    return a.sb.localizedStandardCompare(b.sb) == .orderedDescending
                }), id: \.milb_id) { item in
                    
                    leaderPlayoffsView(leaderData: item)
                    
                }.eraseToAnyView()
            default:
                return ForEach(viewModel.statisticsListPlayoffs, id: \.milb_id) { item in
                    
                    leaderPlayoffsView(leaderData: item)
                    
                }.eraseToAnyView()
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
    
    var leaderData: leadersRegular
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 35, height: 35)
                VStack (alignment: .leading) {
                    Text(leaderData.name)
                        .modifier(textModifier(font: .body, fontColor: .primary, fontDesing: .default))
                    Text(leaderData.team)
                        .modifier(textModifier(font: .footnote, fontColor: .secondary, fontDesing: .default))
                }
                Spacer()
                Text(leaderData.avg)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.primary)
                
            }
            Divider()
        }
    }
}

struct leaderPlayoffsView: View {
    
    var leaderData: leadersPlayoffs
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 35, height: 35)
                VStack (alignment: .leading) {
                    Text(leaderData.name)
                        .modifier(textModifier(font: .body, fontColor: .primary, fontDesing: .default))
                    Text(leaderData.team)
                        .modifier(textModifier(font: .footnote, fontColor: .secondary, fontDesing: .default))
                }
                Spacer()
                Text(leaderData.avg)
                    .modifier(textModifier(font: .headline, fontColor: .primary, fontDesing: .default))
                
            }
            Divider()
        }
    }
}




