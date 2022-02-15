//
//  NotificationFollowEventTableViewCell.swift
//  Instagram
//
//  Created by Admin on 12.02.2022.
//

import UIKit


protocol NotificationFollowEventTableViewCellDelegate: AnyObject {
    func followAndUnfollowDidTapp(model: UserNotification)
}


class NotificationFollowEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationFollowEventTableViewCell"
    
    weak var delegate: NotificationFollowEventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "@therock started following you."
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(photoImageView)
        contentView.addSubview(label)
        contentView.addSubview(followButton)
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        configureForFollow()
        selectionStyle = .none
    }
    
    @objc private func didTapFollowButton() {
        guard let model = model else {
            return
        }
        delegate?.followAndUnfollowDidTapp(model: model)
    }
    
    public func configure(with model: UserNotification) {
        self.model = model
        
        
        switch model.type {
        case .like(_):
            break
        case .follow(let state):
            switch state {
            case .following:
                // configure unfollow button
                configureForFollow()
            case .not_following:
                // configure follow button
                followButton.setTitle("Follow", for: .normal)
                followButton.setTitleColor(.white, for: .normal)
                followButton.layer.borderWidth = 0.0
                followButton.backgroundColor = .link
                
            }
        }
        label.text = model.text
        photoImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }
    
    private func configureForFollow() {
        followButton.setTitle("Unfollow", for: .normal)
        followButton.setTitleColor(.label, for: .normal)
        followButton.layer.borderWidth = 1.0
        followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = nil
        label.text = nil
        photoImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        photoImageView.frame = CGRect(x: 3, y: 3, width: contentView.height-6, height: contentView.height-6)
        photoImageView.layer.cornerRadius = photoImageView.height/2
        
        let size: CGFloat = 100.0
        
        let buttonHeight: CGFloat = 40
        followButton.frame = CGRect(x: contentView.width-size-5, y: (contentView.height-buttonHeight)/2, width: size, height: buttonHeight)
        label.frame = CGRect(x: photoImageView.right + 5, y: 0, width: contentView.width-size-photoImageView.width-16, height: contentView.height)
    }
    
    
}
