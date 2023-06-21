//
//  PostsViewModel.swift
//  BringCloser
//
//  Created by Le Viet Tung on 20/06/2023.
//

import Foundation

@MainActor
class PostsViewModel: ObservableObject {
    private var postsRepository : PostsRepositoryProtocol
    
    @Published var posts : Loadable<[Post]> = .loading
    
    init(postRepository: PostsRepositoryProtocol = PostsRepository()) {
        self.postsRepository = postRepository
    }
    
    func fetchPosts() {
        Task {
            do {
                posts = .loaded(try await postsRepository.fetchPosts())
            } catch {
                print("[PostsViewModel] Cannot fetch posts: \(error)")
            }
        }
    }
    
    func makeCreateAction() -> NewPostForm.CreateAction {
        return { [weak self] post in
            try await self?.postsRepository.create(post)
            self?.posts.value?.insert(post, at: 0)
        }
    }
    
    func makeDeleteAction(for post : Post) -> PostRow.DeleteAction {
        return { [weak self] in
            try await self?.postsRepository.delete(post)
            self?.posts.value?.removeAll() { $0.id == post.id }
        }
    }
}
