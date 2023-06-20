//
//  Post.swift
//  BringCloser
//
//  Created by Le Viet Tung on 20/06/2023.
//

import Foundation

struct Post : Identifiable, Encodable {
    var id = UUID()
    var title : String
    var content : String
    var authorName : String
    var timestamp = Date()
    
    func contains(_ keyword : String) -> Bool {
        let properties = [title, content, authorName].map { $0.lowercased() }
        return !properties.filter { $0.contains(keyword.lowercased()) }.isEmpty
    }
}

extension Post {
    static let testPost = Post(
        title: "Lorem ipsum",
        content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        authorName: "Jamie Harris"
    )
}

