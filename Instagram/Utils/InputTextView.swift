//
//  InputTextView.swift
//  Instagram
//
//  Created by Ederson Machado Berti on 28/08/21.
//

import UIKit

class InputTextView: UITextView {
    
    // MARK: - Properties
    
    var placeholderText: String? {
        didSet {
            placehoderLabel.text = placeholderText
        }
    }
    
    private let placehoderLabel: UILabel = {
       let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    var placeholderShouldCenter = true {
        didSet {
            if placeholderShouldCenter {
                placehoderLabel.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 8)
                placehoderLabel.center(inView: self)
            } else {
                placehoderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 4, paddingLeft: 8)
            }
        }
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        addSubview(placehoderLabel)
        placehoderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 4, paddingLeft: 8)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func handleTextDidChange() {
        placehoderLabel.isHidden = !text.isEmpty
    }
}
