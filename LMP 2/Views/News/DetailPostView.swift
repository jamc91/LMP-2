//
//  DetailPostView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 06/05/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI
import WebKit
import SDWebImageSwiftUI

struct DetailPostView: View {
    
    @StateObject var detailPostViewModel: DetailPostViewModel
    @State private var size: CGSize = .zero
    let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'><style> figure { margin: 0; padding: 0; } body { margin: 0; padding: 0; } strong { color: black; } p { color: gray; font-size: 20px; font-family: -apple-system; } img { border-radius:10px; width:auto; height:auto; max-width:100%; max-height:90vh; } a:link { color: 0080ff; font-size: 20px; font-weight: bold; text-decoration: none; } @media (prefers-color-scheme: dark) { strong { color: white; } p { color: silver; }} </style></header>"
    
    init(slug: String) {
        self._detailPostViewModel = StateObject(wrappedValue: DetailPostViewModel(slug: slug))
    }
    
    var body: some View {
            ScrollView {
                VStack(spacing: 0) {
                    GeometryReader { proxy in
                        WebImage(url: URL(string: detailPostViewModel.detailPost?.cover ?? ""))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
                    }
                    .frame(height: 220)
                    VStack(alignment: .leading, spacing: 5) {
                        Text(detailPostViewModel.detailPost?.date ?? Date(), style: .date)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                        Text(detailPostViewModel.detailPost?.title ?? "")
                            .font(.title2)
                            .fontWeight(.bold)
                        Divider()
                            .padding(.vertical)
                        AttributedText(htmlContent: "\(headerString) \(detailPostViewModel.detailPost?.content ?? "")", size: $size)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, idealHeight: size.height, maxHeight: .infinity)
                            
                    }
                    .padding(20)
                    Divider()
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                            Text("Share Post")
                                .bold()
                        }
                        .foregroundColor(.primary)
                    }
                    .tint(.gray)
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .padding()
                }
            }
            .overlay {
                if detailPostViewModel.isLoading {
                    loading
                }
            }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailPostView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DetailPostView(slug: "estos-son-los-candidatos-al-premio-baldomero-almada")
                .preferredColorScheme(.light)
            DetailPostView(slug: "estos-son-los-candidatos-al-premio-baldomero-almada")
                .preferredColorScheme(.dark)
        }
    }
}

extension DetailPostView {
    var loading: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            VStack(spacing: 5) {
                ProgressView()
                Text("LOADING")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct AttributedText: UIViewRepresentable {
    let htmlContent: String
    @Binding var size: CGSize
    
    private let webView = WKWebView()
    var sizeObserver: NSKeyValueObservation?
    
    func makeUIView(context: Context) -> WKWebView {
        webView.scrollView.isScrollEnabled = false
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        webView.scrollView.backgroundColor = UIColor.clear
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: AttributedText
        var sizeObserver: NSKeyValueObservation?
        
        init(parent: AttributedText) {
            self.parent = parent
            sizeObserver = parent.webView.scrollView.observe(\.contentSize, options: [.new], changeHandler: { (object, change) in
                parent.size = change.newValue ?? .zero
            })
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url, navigationAction.navigationType == .linkActivated {
                UIApplication.shared.open(url)
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        }
    }
}


