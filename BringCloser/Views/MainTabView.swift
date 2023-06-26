//
//  MainTabView.swift
//  BringCloser
//
//  Created by Le Viet Tung on 21/06/2023.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            PostList()
                .tabItem {
                    Label("Posts", systemImage: "list.dash")
                }
            PostList(viewModel: PostsViewModel(filter: .favorites))
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
