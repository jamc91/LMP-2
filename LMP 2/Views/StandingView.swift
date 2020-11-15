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
    
    @ObservedObject var viewModel: ViewModel
    @State private var league = 0
    
    var body: some View {
        VStack (spacing: 10) {
            TopHeaderView(viewModel: viewModel, title: "Standings", showCalendarButton: false).padding(.horizontal, 20)
            Picker("", selection: $league) {
                Text("LMP").tag(0)
                Text("MLB").tag(1)
            }.pickerStyle(SegmentedPickerStyle())
            .padding()
            if league == 0 {
                Section(header: HeaderSectionView(title: "First").padding(.horizontal)) {
                    StandingRegularSeasonView(standing: viewModel.standingLMP.response.first).padding(.horizontal, 20)
                }
            } else {
                StandingMLBView(viewModel: viewModel)
            }
        }
    }
}


struct StandingView_Previews: PreviewProvider {
    static var previews: some View {
        
        StandingView(viewModel: ViewModel())
        
    }
}

//MARK: - Standings View

struct StandingRegularSeasonView: View {
    
    var standing: [StandingRegular]
    
    var body: some View {
        VStack {
            HeaderStandingMLB(items: [("TEAM", .infinity), ("W", 25), ("L", 25), ("PCT", 35), ("GB", 35)])
            ForEach(standing) { item in
                HStack {
                    Image(item.teamName.teamName())
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .center)
                    Text(item.teamName)
                    Spacer()
                    Group {
                        HStack (spacing: 1) {
                            Text("\(item.wins)")
                                .frame(width: 25, alignment: .center)
                            Text("\(item.losses)")
                                .frame(width: 25, alignment: .center)
                            Text(item.percent)
                                .frame(width: 40, alignment: .center)
                            Text(item.gb)
                                .frame(width: 35, alignment: .center)
                        }
                    }
                    .font(.subheadline)
                    .lineLimit(1)
                    
                }.padding(.horizontal, 10)
                Divider()
            }
        }
        .padding(5)
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
        }.padding(.top, 15)
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
