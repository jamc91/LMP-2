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
            typeStastistic(type: pickerSelection)
        }
        .padding()
        .background(Color("BackgroundCell"))
        .cornerRadius(10)
    }
    func typeStastistic(type: Int) -> some View {
        switch type {
        case 0:
            return ForEach(statisticsData.staticticsList.sorted(by: { (a, b) -> Bool in
                return a.avg.localizedStandardCompare(b.avg) == .orderedDescending
            }), id: \.milb_id) { item in
                                
                leaderView(leaderData: item)
                    
            }.eraseToAnyView()
            case 1:
                return ForEach(statisticsData.staticticsList.sorted(by: { (a, b) -> Bool in
                    return a.r.localizedStandardCompare(b.r) == .orderedDescending
                }), id: \.milb_id) { item in
                                
                leaderView(leaderData: item)
                    
            }.eraseToAnyView()
            case 2:
                return ForEach(statisticsData.staticticsList.sorted(by: { (s1, s2) -> Bool in
                    return s1.hr.localizedStandardCompare(s2.hr) == .orderedDescending
                }), id: \.milb_id) { item in
                                
                leaderView(leaderData: item)
                    
            }.eraseToAnyView()
            case 3:
                return ForEach(statisticsData.staticticsList.sorted(by: { (a, b) -> Bool in
                    return a.rbi.localizedStandardCompare(b.rbi) == .orderedDescending
                }), id: \.milb_id) { item in
                                
                leaderView(leaderData: item)
                    
            }.eraseToAnyView()
            case 4:
                return ForEach(statisticsData.staticticsList.sorted(by: { (a, b) -> Bool in
                    return a.sb.localizedStandardCompare(b.sb) == .orderedDescending
                }), id: \.milb_id) { item in
                                
                leaderView(leaderData: item)
                    
            }.eraseToAnyView()
        default:
            return ForEach(statisticsData.staticticsList, id: \.milb_id) { item in
                                
                leaderView(leaderData: item)
                    
            }.eraseToAnyView()
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        
            StatisticsView()
    
    }
}



struct leaderView: View {
    
    var leaderData: Leaders

    var body: some View {
        VStack {
            HStack {
                URLImage(url: leaderData.thumb)
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

struct URLImage: View {
    
    let imageURL: String
    @ObservedObject var imageDownloader = ImageLoader()
    
    init(url: String) {
        self.imageURL = url
        self.imageDownloader.downloadImage(url: url)
    }
    
    var body: some View {
        if let imageData = self.imageDownloader.downLoadedData {
            let img = UIImage(data: imageData)
            return Image(uiImage: img!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .frame(width: 50, height: 50, alignment: .leading)
                    .padding(.trailing, 5)
            
        }
        else
        {
            return Image(systemName: "person.crop.circle")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(width: 50, height: 50, alignment: .leading)
                .padding(.trailing, 5)
            
        }
        
    }
    
}


