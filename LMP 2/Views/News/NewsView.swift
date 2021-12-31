//
//  NewsView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 06/05/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsView: View {
    
    @StateObject var newsViewModel: NewsViewModel
    
    init(posts: [Post]) {
        self._newsViewModel = StateObject(wrappedValue: NewsViewModel(posts: posts))
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(newsViewModel.posts) { post in
                    NavigationLink(
                        destination: DetailPostView(slug: post.slug),
                        label: {
                            PostCell(post: post)
                                .onAppear { newsViewModel.loadMorePosts(post: post)
                                }
                        })
                        .buttonStyle(StaticButtonStyle())
                    Divider()
                }
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle("News")
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView(posts: [])
    }
}
