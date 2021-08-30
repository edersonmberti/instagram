//
//  PostViewModel.swift
//  Instagram
//
//  Created by Ederson Machado Berti on 30/08/21.
//

import Foundation

struct PostViewModel {
    private let post: Post
    
    var imageUrl: URL? { URL(string: post.imageUrl) }
    
    var caption: String { return post.caption }
    
    var likes: Int { post.likes }
    
    init(post: Post) {
        self.post = post
    }
}
