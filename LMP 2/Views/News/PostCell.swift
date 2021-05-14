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
            WebImage(url: post.cover)
                .resizable()
                .placeholder {
                    RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                        .foregroundColor(Color(.systemGray5))
                }
                .indicator(.activity)
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width-40, height: 225, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
            VStack(alignment: .leading, spacing: 5) {
                Text(post.title)
                    .font(.system(size: 20, weight: .semibold, design: .serif))
                    .italic()
                    .lineLimit(2)
                Text(post.description.replacingOccurrences(of: "[&]|acute;", with: "", options: .regularExpression, range: nil))
                    .lineLimit(2)
                Text(post.date, style: .date)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(post: Constats.shared.posts.response.posts.first!)
            .previewLayout(.sizeThatFits)
    }
}
