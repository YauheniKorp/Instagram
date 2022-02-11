//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Instagram
//
//  Created by Admin on 06.02.2022.
//

import UIKit


protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)

}

class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .systemYellow
        return imageView
    }()
    
    private let postsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Posts", for: .normal)
        return button
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Following", for: .normal)
        return button
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Followers", for: .normal)
        return button
    }()
    
    private let editProfile: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Edit Your Profile", for: .normal)
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Yauheni Korp"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "This is the first account."
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addActions()
        clipsToBounds = true
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addActions() {
        postsButton.addTarget(self, action: #selector(postButtonDidTapped), for: .touchUpInside)
        followersButton.addTarget(self, action: #selector(followersButtonDidTapped), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(followingButtonDidTapped), for: .touchUpInside)
        editProfile.addTarget(self, action: #selector(editProfileButtonDidTapped), for: .touchUpInside)

    }
    
    private func addSubviews() {
        addSubview(photoImageView)
        addSubview(postsButton)
        addSubview(followersButton)
        addSubview(followingButton)
        addSubview(editProfile)
        addSubview(nameLabel)
        addSubview(bioLabel)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let photoImageSize = width/4
        photoImageView.frame = CGRect(x: 5, y: 5, width: photoImageSize, height: photoImageSize).integral
        photoImageView.layer.cornerRadius = photoImageSize/2
        
        let buttonHeight = photoImageSize/2
        let buttonWidth = (width-10-photoImageSize)/3
        
        postsButton.frame = CGRect(x: photoImageView.right, y: 5, width: buttonWidth, height: buttonHeight)
        followersButton.frame = CGRect(x: postsButton.right, y: 5, width: buttonWidth, height: buttonHeight)
        followingButton.frame = CGRect(x: followersButton.right, y: 5, width: buttonWidth, height: buttonHeight)
        editProfile.frame = CGRect(x: photoImageView.right, y: 5 + buttonHeight, width: buttonWidth*3, height: buttonHeight)
        nameLabel.frame = CGRect(x: 5, y: 5 + photoImageSize, width: width-10, height: 50)
        
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        bioLabel.frame = CGRect(x: 5, y: 5 + nameLabel.bottom, width: width-10, height: bioLabelSize.height)

    }
    
    // MARK: - Actions
    
    @objc private func postButtonDidTapped() {
        self.delegate?.profileHeaderDidTapPostButton(self)
    }
    
    @objc private func followersButtonDidTapped() {
        self.delegate?.profileHeaderDidTapFollowersButton(self)
    }
    
    @objc private func followingButtonDidTapped() {
        self.delegate?.profileHeaderDidTapFollowingButton(self)
    }
    
    @objc private func editProfileButtonDidTapped() {
        self.delegate?.profileHeaderDidTapEditProfileButton(self)
    }
    
}
