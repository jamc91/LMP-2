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
        ZStack {
            if !detailPostViewModel.isLoading {
                ScrollView {
                    WebImage(url: URL(string: detailPostViewModel.detailPost?.cover ?? ""))
                        .resizable()
                        .placeholder {
                            RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                                .foregroundColor(Color(.systemGray5))
                        }
                        .indicator(.activity)
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 350, alignment: .center)
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
            } else {
                loading
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailPostView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPostView(slug: "")
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
