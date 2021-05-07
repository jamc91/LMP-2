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
    
    @EnvironmentObject var viewModel: ContentViewModel
    @State private var index = 2
    
    var body: some View {
        NavigationView {
            List(viewModel.posts) { post in
                NavigationLink(
                    destination: DetailPostView(slug: post.slug),
                    label: {
                        PostCell(post: post)
                            .onAppear(perform: { loadMorePosts(post: post) })
                    })
                    .buttonStyle(PlainButtonStyle())
            }
            .navigationTitle("News")
        }
        .tabItem { Label("News", systemImage: "newspaper.fill") }
        .accentColor(.blue)
        .animation(nil)
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
            .environmentObject(ContentViewModel(posts: Constats.shared.posts.response.posts))
    }
}

extension NewsView {
    func loadMorePosts(post: Post) {
        if viewModel.posts.last == post {
            viewModel.getPosts(page: index)
            self.index += 1
        }
    }
}
