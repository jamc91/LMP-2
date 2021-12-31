//
//  HomeView.swift
//  LMP 2
//
//  Created by Jesús Medina Camargo on 25/12/21.
//  Copyright © 2021 Jesús Medina Camargo. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                SectionView(title: "Scheduled Games") {
                    ForEach(homeViewModel.scheduledGames) { game in
                        CalendarRow(game: game)
                    }
                }
                .frame(height: 250)
                SectionView(title: "Latest Posts", buttonSection: {
                    NavigationLink(destination: NewsView(posts: homeViewModel.posts)) {
                        Text("See All")
                    }
                }, content: {
                    ForEach(homeViewModel.posts) { post in
                        NavigationLink(destination: DetailPostView(slug: post.slug)) {
                            PostCell(post: post)
                        }
                    }
                    .buttonStyle(StaticButtonStyle())
                })
                .frame(height: 350)
                Section(header: VStack {
                    TextHeader(title: "More to Explore").padding(.horizontal, 20).padding(.top, 15).padding(.bottom, -1)
                    Divider().padding(.leading, 20)
                }) {
                    NavigationLink(destination: Text("Movements")) {
                        VStack {
                            HStack {
                                Text("Movements")
                                    .font(.title2)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .foregroundColor(.blue)
                            .padding(.horizontal, 20)
                            Divider().padding(.leading, 20)
                        }
                    }
                    NavigationLink(destination: Text("Standings")) {
                        VStack {
                            HStack {
                                Text("Standings")
                                    .font(.title2)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .foregroundColor(.blue)
                            .padding(.horizontal, 20)
                            Divider().padding(.leading, 25)
                        }
                    }
                }
            }
            .navigationBarTitle("Today")
            .overlay {
                if homeViewModel.isLoading {
                    LoadingView()
                }
            }
        }
        .navigationViewStyle(.stack)
        .tabItem { Label("Today", systemImage: "doc.text.image.fill") }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
            HomeView()
    }
}

struct TextHeader: View {
    
    let title : String
    
     var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .listRowInsets(EdgeInsets())
    }
}


struct StaticButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}
