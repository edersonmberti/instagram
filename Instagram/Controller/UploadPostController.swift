//
//  UploadPostController.swift
//  Instagram
//
//  Created by Ederson Machado Berti on 28/08/21.
//

import UIKit

protocol UpdatePostControllerProtocol: AnyObject {
    func controllerDidFinishUploadingPost(_ controller: UploadPostController)
}

class UploadPostController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: UpdatePostControllerProtocol?
    
    var selectedImage: UIImage? {
        didSet {
            photoImageView.image = selectedImage
        }
    }
    
    var currentUser: User?
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var captionTextView: InputTextView = {
        let textView = InputTextView()
        textView.placeholderText = "Enter caption..."
        textView.delegate = self
        textView.placeholderShouldCenter = false
        return textView
    }()
    
    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0/100"
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    // MARK: - Actions
    
    @objc func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapDone() {
        guard let image = selectedImage else { return }
        guard let caption = captionTextView.text else { return }
        guard let currentUser = currentUser else { return }
        
        showLoader(true)
        
        PostService.uploadPost(caption: caption, image: image, user: currentUser) { error in
            self.showLoader(false)
            if let error = error {
                print("DEBUG: Error to upload post \(error.localizedDescription)")
                return
            }
            
            self.delegate?.controllerDidFinishUploadingPost(self)
        }
    }
    
    // MARK: - Helpers
    
    func checkMaxLength(_ textView: UITextView) {
        if (textView.text.count) > 100 {
            textView.deleteBackward()
        }
    }
    
    func setupLayout() {
        view.backgroundColor = .white
        
        navigationItem.title = "Upload Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(didTapDone))
        
        view.addSubview(photoImageView)
        photoImageView.setDimensions(height: 180, width: 180)
        photoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        photoImageView.centerX(inView: view)
        photoImageView.layer.cornerRadius = 10
        
        view.addSubview(captionTextView)
        captionTextView.anchor(top: photoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 12, paddingRight: 12, height: 64)
        
        view.addSubview(characterCountLabel)
        characterCountLabel.anchor(bottom: captionTextView.bottomAnchor, right: view.rightAnchor, paddingBottom: -8, paddingRight: 12)
    }
}

// MARK: - UITextFieldDeletage

extension UploadPostController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView)
        let count = textView.text.count
        characterCountLabel.text = "\(count)/100"
    }
}
