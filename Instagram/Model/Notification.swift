//
//  Notification.swift
//  Instagram
//
//  Created by Ederson Machado Berti on 07/09/21.
//

import Firebase

enum NotificationType: Int {
    case like
    case follow
    case comment
    
    var notificationMessage: String {
        switch self {
        case .like: return " like your post."
        case .follow: return " started following you."
        case .comment: return " commented on yout post"
        }
    }
}

struct Notification {
    let id: String
    let uid: String
    var postImageUrl: String?
    var postId: String?
    let userProfileImageUrl: String
    let username: String
    let timestamp: Timestamp
    let type: NotificationType
    
    init(dictionary: [String: Any]) {
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.id = dictionary["id"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.postId = dictionary["postId"] as? String ?? ""
        self.postImageUrl = dictionary["postImageUrl"] as? String ?? ""
        self.userProfileImageUrl = dictionary["userProfileImageUrl"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.type = NotificationType(rawValue: dictionary["type"] as? Int ?? 0) ?? .like
    }
}
