//
//  CommentInputAcessoryView.swift
//  Instagram
//
//  Created by Ederson Machado Berti on 31/08/21.
//

import UIKit

protocol CommentInputAcessoryViewDelegate: AnyObject {
    func inputView(_ inputView: CommentInputAcessoryView, wantsToUploadComment comment: String)
}

class CommentInputAcessoryView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: CommentInputAcessoryViewDelegate?
    
    private let commentTextView: InputTextView = {
      let textView = InputTextView()
        textView.placeholderText = "Enter comment.."
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isScrollEnabled = false
        textView.placeholderShouldCenter = true
        return textView
    }()
    
    private let postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleCommentUpload), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        autoresizingMask = .flexibleHeight
        
        addSubview(postButton)
        postButton.anchor(top: topAnchor, right: rightAnchor, paddingRight: 8)
        postButton.setDimensions(height: 50, width: 50)
        
        addSubview(commentTextView)
        commentTextView.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: postButton.leftAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
        
        let divider = UIView()
        divider.backgroundColor = .systemGroupedBackground
        addSubview(divider)
        divider.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    // MARK: - Action
    
    @objc func handleCommentUpload() {
        delegate?.inputView(self, wantsToUploadComment: commentTextView.text)
    }
    
    func clearCommentTextView() {
        commentTextView.text = nil
        commentTextView.placehoderLabel.isHidden = false
    }
}
