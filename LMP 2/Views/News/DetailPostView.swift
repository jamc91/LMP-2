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
    
    @EnvironmentObject var viewModel: ContentViewModel
    let slug: String
    @State private var showPost = false
    
    var body: some View {
        ZStack {
            if showPost {
                ScrollView {
                    WebImage(url: viewModel.detailPost?.cover)
                        .resizable()
                        .placeholder {
                            RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                                .foregroundColor(Color(.systemGray5))
                        }
                        .indicator(.activity)
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 350, alignment: .center)
                    VStack(alignment: .leading, spacing: 5) {
                        Text(viewModel.detailPost?.title ?? "")
                            .font(.system(size: 20, weight: .semibold, design: .serif))
                            .italic()
                        Text(viewModel.detailPost?.date ?? Date(), style: .date)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(viewModel.detailPost?.content.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil) ?? "")
                    }
                    .padding(10)
                    .frame(width: UIScreen.main.bounds.width)
                }
            } else {
                loading
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.getDetailPost(slug: slug) {
                self.showPost = true
            }
        }
        .onDisappear {
            viewModel.detailPost = nil
        }
    }
}

struct DetailPostView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPostView(slug: "")
            .environmentObject(ContentViewModel(detailPost: Constats.shared.detailPost.response))
    }
}

extension DetailPostView {
    var loading: some View {
        Group {
            Spacer(minLength: UIScreen.main.bounds.height / 3)
            ProgressView()
        }
    }
}
