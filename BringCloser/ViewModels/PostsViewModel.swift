//
//  PostsViewModel.swift
//  BringCloser
//
//  Created by Le Viet Tung on 20/06/2023.
//

import Foundation

@MainActor
class PostsViewModel: ObservableObject {
    @Published var posts = [Post.testPost]
    
    func makeCreateAction() -> NewPostForm.CreateAction {
        return { [weak self] post in
            try await PostsRepository.create(post)
            self?.posts.insert(post, at: 0)
        }
    }
}
