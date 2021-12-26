//
//  DetailPostView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 06/05/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailPostView: View {
    
    @StateObject var detailPostViewModel: DetailPostViewModel
    
    init(slug: String) {
        self._detailPostViewModel = StateObject(wrappedValue: DetailPostViewModel(slug: slug))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                GeometryReader { proxy in
                    WebImage(url: URL(string: detailPostViewModel.detailPost?.cover ?? ""))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
                }
                .frame(height: 300)
                VStack(alignment: .leading, spacing: 5) {
                    Text(detailPostViewModel.detailPost?.title ?? "")
                        .font(.system(size: 20, weight: .semibold, design: .serif))
                        .italic()
                    Text(detailPostViewModel.detailPost?.date ?? Date(), style: .date)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(detailPostViewModel.detailPost?.content.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) ?? "")
                }
                .padding(10)
                .frame(width: UIScreen.main.bounds.width)
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
        DetailPostView(slug: "isaias-tejeda-se-suma-a-naranjeros-de-cara-a-la-postemporada")
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
