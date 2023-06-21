//
//  PostList.swift
//  BringCloser
//
//  Created by Le Viet Tung on 20/06/2023.
//

import SwiftUI
struct PostList: View {
    @StateObject var viewModel = PostsViewModel()
    
    @State private var searchText = ""
    @State private var showNewPostForm = false
    
    var body: some View {
        NavigationStack{
            Group {
                switch viewModel.posts {
                case .loading:
                    ProgressView()
                case let .error(error):
                    EmptyListView(
                        title: "Cannot load posts",
                        message: error.localizedDescription,
                        retryAction: { viewModel.fetchPosts()}
                    )
                case .empty:
                    EmptyListView(
                        title: "No posts",
                        message: "There aren't any posts yet."
                    )
                case let .loaded(posts):
                    List(posts) { post in
                        if searchText.isEmpty || post.contains(searchText) {
                            PostRow(
                                post: post,
                                deleteAction: viewModel.makeDeleteAction(for: post))
                        }
                    }
                    .searchable(text: $searchText)
                    .animation(.default, value: posts)
                }
            }
            .navigationTitle("Posts")
            .toolbar {
                Button {
                        showNewPostForm = true
                } label: {
                        Label("New Post", systemImage: "square.and.pencil")
                    }
            }
            .sheet(isPresented: $showNewPostForm) {
                NewPostForm(createAction: viewModel.makeCreateAction())
            }
        }
        .onAppear {
            viewModel.fetchPosts()
        }
    }
}

#if DEBUG
struct PostList_Previews: PreviewProvider {
    static var previews: some View {
        ListPreview(state: .loaded([Post.testPost]))
        ListPreview(state: .empty)
        ListPreview(state: .error)
        ListPreview(state: .loading)
    }
    
    @MainActor
    private struct ListPreview: View {
        let state: Loadable<[Post]>
     
        var body: some View {
            let postsRepository = PostsRepositoryStub(state: state)
            let viewModel = PostsViewModel(postRepository: postsRepository)
            PostList(viewModel: viewModel)
        }
    }
}
#endif
