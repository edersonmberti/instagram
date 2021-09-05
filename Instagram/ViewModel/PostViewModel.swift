//
//  PostViewModel.swift
//  Instagram
//
//  Created by Ederson Machado Berti on 30/08/21.
//

import UIKit

struct PostViewModel {
    var post: Post
    
    var imageUrl: URL? { URL(string: post.imageUrl) }
    
    var userProfileImageUrl: URL? { URL(string: post.ownerImageUrl) }
    
    var username: String { post.ownerUsername }
    
    var caption: String { return post.caption }
    
    var likes: Int { post.likes }
    
    var likeButtonTintColor: UIColor {
        return post.didLike ? .red : .black
    }
    
    var likeButtonImage: UIImage? {
        let imageName = post.didLike ? "like_selected" : "like_unselected"
        return UIImage(named: imageName)
    }
    
    init(post: Post) {
        self.post = post
    }
}
