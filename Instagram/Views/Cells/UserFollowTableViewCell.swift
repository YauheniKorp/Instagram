//
//  UserFollowTableViewCell.swift
//  Instagram
//
//  Created by Admin on 12.02.2022.
//

import UIKit


protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollow(_ model: UserRelationship)
}


enum FollowState {
    case following        
    case not_following
}

struct UserRelationship {
    let name: String
    let username: String
    let type: FollowState
}

class UserFollowTableViewCell: UITableViewCell {
    
    static let identifier = "UserFollowTableViewCell"
    
    weak var delegate: UserFollowTableViewCellDelegate?
    
    private var model: UserRelationship?
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Zhenya"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "@Zhenya"
        label.textColor = .secondaryLabel
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(photoImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(followButton)
        selectionStyle = .none
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        
    }
    
    @objc private func didTapFollowButton() {
        guard let model = model else {
            return
        }

        delegate?.didTapFollowUnfollow(model)
    }
    
    override func prepareForReuse() {
        photoImageView.image = nil
        nameLabel.text = nil
        usernameLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = nil
    }
    
    public func configure(with model: UserRelationship) {
        self.model = model
        nameLabel.text = model.name
        usernameLabel.text = model.username
        
        switch model.type {
        case .following:
            //show unfollow button
            followButton.setTitle("Unfollow", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderWidth = 1.0
            followButton.layer.borderColor = UIColor.label.cgColor
        case .not_following:
            //show follow button
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let sizeOfPhotoImageView = contentView.height-6
        
        photoImageView.frame = CGRect(x: 3, y: 3, width: sizeOfPhotoImageView, height: sizeOfPhotoImageView)
        photoImageView.layer.cornerRadius = sizeOfPhotoImageView / 2
        
        let buttonWidth = contentView.width > 500 ? 220.0 : contentView.width / 3
        followButton.frame = CGRect(x: contentView.width-5-buttonWidth, y: (contentView.height-40)/2, width: buttonWidth, height: 40)
        
        let labelHeight = contentView.height / 2
        
        nameLabel.frame = CGRect(x: photoImageView.right+5, y: 0, width: contentView.width-8-photoImageView.width-followButton.width, height: labelHeight)
        usernameLabel.frame = CGRect(x: photoImageView.right+5, y: nameLabel.bottom, width: contentView.width-8-photoImageView.width-followButton.width, height: labelHeight)
    }
    
}
