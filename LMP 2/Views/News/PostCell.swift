//
//  PostCell.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 06/05/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostCell: View {
    
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader { proxy in
                WebImage(url: URL(string: post.cover))
                    .resizable()
                    .placeholder {
                        RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                            .foregroundColor(Color(.systemGray5))
                    }
                    .indicator(.activity)
                    .aspectRatio(contentMode: .fill)
                    .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            Text(post.date, style: .date)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
            Text(post.title)
                .font(.headline)
                .lineLimit(2)
            Text(post.description.replacingOccurrences(of: "[&]|acute;", with: "", options: .regularExpression, range: nil))
                .lineLimit(2)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .aspectRatio(1.1, contentMode: .fit)
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(post: Constats.shared.posts.response.posts.first!)
            .previewLayout(.sizeThatFits)
    }
}
