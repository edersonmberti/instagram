//
//  NotificationViewModel.swift
//  Instagram
//
//  Created by Ederson Machado Berti on 07/09/21.
//

import UIKit

struct NotificationViewModel {
    var notification: Notification
    
    init(notification: Notification) {
        self.notification = notification
    }
    
    var postImageUrl: URL? { URL(string: notification.postImageUrl  ?? "") }
    
    var profileImageUrl: URL? { URL(string: notification.userProfileImageUrl)}
    
    var notificationMessage: NSAttributedString {
        let username = notification.username
        let message = notification.type.notificationMessage
        let attributedText = NSMutableAttributedString(string: username, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: message, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        attributedText.append(NSAttributedString(string: " 2m", attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.lightGray]))
        
        return attributedText
    }
    
    var shouldHidePostImage: Bool { self.notification.type == .follow }
    
    var shouldHideFollowButton: Bool { self.notification.type != .follow }
    
    var followButtonText: String { notification.userIsFollowed ? "Following" : "Follow" }
    
    var followButtonBackgroundColor: UIColor { notification.userIsFollowed ? .white : .systemBlue }
    
    var followButtonTextColor: UIColor { notification.userIsFollowed ? .black : .white }
}
