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
    
    @StateObject var newsViewModel = NewsViewModel()
    
    var body: some View {
        NavigationView {
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
                            .buttonStyle(PlainButtonStyle())
                        Divider()
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("News")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .tabItem { Label("News", systemImage: "newspaper.fill") }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
