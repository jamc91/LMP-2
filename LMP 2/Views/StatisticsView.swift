//
//  StatisticsView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 01/06/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct StatisticsView: View {
    
    @ObservedObject var statisticsData = RowViewModel()
    @State private var pickerSelection = 0
    @State private var pickerCategorie = 0
    
    var body: some View {
        VStack {
            Picker(selection: $pickerCategorie, label: Text("")) {
                Text("Regular").tag(0)
                Text("Playoffs").tag(1)
            }.pickerStyle(SegmentedPickerStyle())
            Picker(selection: $pickerSelection, label: Text("")) {
                Text("AVG").tag(0)
                Text("R").tag(1)
                Text("HR").tag(2)
                Text("RBI").tag(3)
                Text("SB").tag(4)
            }.pickerStyle(SegmentedPickerStyle())
            typeStastistic(categorie: pickerCategorie, type: pickerSelection)
        }
        .padding()
        .background(Color("BackgroundCell"))
        .cornerRadius(10)
    }
    func typeStastistic(categorie: Int, type: Int) -> some View {
        
        if categorie == 0 {
        switch type {
        case 0:
            return ForEach(statisticsData.statisticsListRegular.sorted(by: { (a, b) -> Bool in
                return a.avg.localizedStandardCompare(b.avg) == .orderedDescending
            }), id: \.milb_id) { item in
                                
                leaderView(leaderData: item)
                    
            }.eraseToAnyView()
            case 1:
                return ForEach(statisticsData.statisticsListRegular.sorted(by: { (a, b) -> Bool in
                    return a.r.localizedStandardCompare(b.r) == .orderedDescending
                }), id: \.milb_id) { item in
                                
                leaderView(leaderData: item)
                    
            }.eraseToAnyView()
            case 2:
                return ForEach(statisticsData.statisticsListRegular.sorted(by: { (s1, s2) -> Bool in
                    return s1.hr.localizedStandardCompare(s2.hr) == .orderedDescending
                }), id: \.milb_id) { item in
                                
                leaderView(leaderData: item)
                    
            }.eraseToAnyView()
            case 3:
                return ForEach(statisticsData.statisticsListRegular.sorted(by: { (a, b) -> Bool in
                    return a.rbi.localizedStandardCompare(b.rbi) == .orderedDescending
                }), id: \.milb_id) { item in
                                
                leaderView(leaderData: item)
                    
            }.eraseToAnyView()
            case 4:
                return ForEach(statisticsData.statisticsListRegular.sorted(by: { (a, b) -> Bool in
                    return a.sb.localizedStandardCompare(b.sb) == .orderedDescending
                }), id: \.milb_id) { item in
                                
                leaderView(leaderData: item)
                    
            }.eraseToAnyView()
        default:
            return ForEach(statisticsData.statisticsListRegular, id: \.milb_id) { item in
                                
                leaderView(leaderData: item)
                
            }.eraseToAnyView()
            }
        } else {
            switch type {
            case 0:
                return ForEach(statisticsData.statisticsListPlayoffs.sorted(by: { (a, b) -> Bool in
                    return a.avg.localizedStandardCompare(b.avg) == .orderedDescending
                }), id: \.milb_id) { item in
                                    
                    leaderPlayoffsView(leaderData: item)
                        
                }.eraseToAnyView()
                case 1:
                    return ForEach(statisticsData.statisticsListPlayoffs.sorted(by: { (a, b) -> Bool in
                        return a.r.localizedStandardCompare(b.r) == .orderedDescending
                    }), id: \.milb_id) { item in
                                    
                    leaderPlayoffsView(leaderData: item)
                        
                }.eraseToAnyView()
                case 2:
                    return ForEach(statisticsData.statisticsListPlayoffs.sorted(by: { (s1, s2) -> Bool in
                        return s1.hr.localizedStandardCompare(s2.hr) == .orderedDescending
                    }), id: \.milb_id) { item in
                                    
                    leaderPlayoffsView(leaderData: item)
                        
                }.eraseToAnyView()
                case 3:
                    return ForEach(statisticsData.statisticsListPlayoffs.sorted(by: { (a, b) -> Bool in
                        return a.rbi.localizedStandardCompare(b.rbi) == .orderedDescending
                    }), id: \.milb_id) { item in
                                    
                    leaderPlayoffsView(leaderData: item)
                        
                }.eraseToAnyView()
                case 4:
                    return ForEach(statisticsData.statisticsListPlayoffs.sorted(by: { (a, b) -> Bool in
                        return a.sb.localizedStandardCompare(b.sb) == .orderedDescending
                    }), id: \.milb_id) { item in
                                    
                    leaderPlayoffsView(leaderData: item)
                        
                }.eraseToAnyView()
            default:
                return ForEach(statisticsData.statisticsListPlayoffs, id: \.milb_id) { item in
                                    
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
                        .font(.system(.headline))
                        .foregroundColor(.primary)
                    Text(leaderData.team)
                        .font(.system(.body))
                        .foregroundColor(.secondary)
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
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(.primary)
                    Text(leaderData.team)
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(.secondary)
                }
                Spacer()
                Text(leaderData.avg)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.primary)
                
            }
            Divider()
        }
    }
}






