//
//  StandingView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 21/05/20.
//  Copyright © 2020 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI
import WebKit

struct StandingView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    @State private var league = 0
    
    var body: some View {
        VStack (spacing: 10) {
            HeaderView(title: "Standings", showCalendarButton: false)
            Picker("", selection: $league) {
                Text("LMP").tag(0)
                Text("MLB").tag(1)
            }.pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            if league == 0 {
                Section(header: HeaderSectionView(title: "First").padding(.horizontal)) {
                    StandingRegularSeasonView(standing: viewModel.standingLMP.response.first).padding(.horizontal, 20)
                }
                Section(header: HeaderSectionView(title: "Second").padding(.horizontal)) {
                    StandingRegularSeasonView(standing: viewModel.standingLMP.response.second).padding(.horizontal, 20)
                }
                Section(header: HeaderSectionView(title: "General").padding(.horizontal)) {
                    StandingRegularSeasonView(standing: viewModel.standingLMP.response.general).padding(.horizontal, 20)
                }
                Section(header: HeaderSectionView(title: "Points").padding(.horizontal)) {
                    StandingPointsView(standing: viewModel.standingLMP.response.points).padding(.horizontal, 20)
                }
            } else {
                StandingMLBView(viewModel: viewModel).padding(.horizontal, 20)
            }
        }
    }
}


/*struct StandingView_Previews: PreviewProvider {
    static var previews: some View {
        
        StandingViewTest()
        
    }
}*/


struct StandingTextView: View {
    
    var teamImage: String
    var teamName: String
    var text: [(value: String, width: CGFloat)]
    
    var body: some View {
        HStack {
            Image(teamImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25, alignment: .center)
            Text(teamName.shortName())
                .font(.subheadline)
            Spacer()
            ForEach(text.indices) { idx in
                Text(text[idx].value)
                    .font(.subheadline)
                    .foregroundColor(.secondary
                    )
                    .frame(width: text[idx].width)
            }
        }.padding(3)
    }
}

struct HeaderTextView: View {
    
    var text: [(value: String, width: CGFloat)]
    
    var body: some View {
        
        HStack {
            Spacer()
            ForEach(text.indices) { idx in
                Text(text[idx].value)
                    .font(.subheadline)
                    .foregroundColor(.secondary
                    )
                    .frame(width: text[idx].width)
            }
        }.padding(3)
    }
}


//MARK: - Standings View

struct StandingRegularSeasonView: View {
    
    var standing: [StandingRegular]
    
    var body: some View {
        VStack (alignment: .leading) {
            
            HeaderTextView(text: [
                (value: "W", width: 25),
                (value: "L", width: 25),
                (value: "PCT", width: 40),
                (value: "GB", width: 35),
                (value: "PTS", width: 40),
            ])
            Divider()
            ForEach(standing) { item in
                StandingTextView(teamImage: item.teamName.teamName(),
                                 teamName: item.name,
                                 text: [
                                    (value: "\(item.wins)", width: 25),
                                    (value: "\(item.losses)", width: 25),
                                    (value: "\(item.percent)", width: 40),
                                    (value: "\(item.gb)", width: 35),
                                    (value: "\(item.pts)", width: 40),
                                 ])
                
                
            }
        }
        .padding(10)
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}

struct StandingPointsView: View {
    
    var standing: [StandingPoints]
    
    var body: some View {
        VStack (alignment: .leading) {
            
            HeaderTextView(text: [
                (value: "1st", width: 40),
                (value: "2nd", width: 40),
                (value: "Total", width: 50)
            ])
            Divider()
            ForEach(standing) { item in
                StandingTextView(teamImage: item.teamName.teamName(),
                                 teamName: item.name,
                                 text: [
                                    (value: "\(item.first)", width: 40),
                                    (value: "\(item.second)", width: 40),
                                    (value: "\(item.total)", width: 50)
                                    
                                 ])
                
                
            }
        }
        .padding(10)
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
}

struct HeaderSectionView: View {
    
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.bold)
                .font(.system(size: 22))
            Spacer()
        }.padding(.top, 10)
    }
}

struct WebView: UIViewRepresentable {
    
    var url: String
    
    func makeCoordinator() -> ContentController {
        ContentController(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        guard let urlString = URL(string: url) else { return WKWebView() }
        let request = URLRequest(url: urlString)
        
        let wkWebView = WKWebView()
        wkWebView.navigationDelegate = context.coordinator
        wkWebView.uiDelegate = context.coordinator
        wkWebView.load(request)
        return wkWebView
        
        
        
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        
    }
    
    class ContentController: NSObject, WKNavigationDelegate, WKUIDelegate {
        
        private let parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.getElementById('react-header').remove();", completionHandler: nil)
            webView.evaluateJavaScript("document.getElementById('ad-top-banner-sm').remove();", completionHandler: nil)
            webView.evaluateJavaScript("document.getElementById('react-footer').remove();", completionHandler: nil)
            
        }
    }
}
