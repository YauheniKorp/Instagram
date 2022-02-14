//
//  NotificationLikeEventTableViewCell.swift
//  Instagram
//
//  Created by Admin on 12.02.2022.
//

import SDWebImage
import UIKit


protocol NotificationLikeEventTableViewCellDelegate: AnyObject {
    func didTapRelatedPostButton(model: UserNotification)
}


class NotificationLikeEventTableViewCell: UITableViewCell {

    static let identifier = "NotificationLikeEventTableViewCell"
    
    private var model: UserNotification?
    
    weak var delegate: NotificationLikeEventTableViewCellDelegate?
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "@zhenya liked your photo"
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "moun"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(photoImageView)
        contentView.addSubview(label)
        contentView.addSubview(postButton)
        postButton.addTarget(self, action: #selector(postButtonDidTap), for: .touchUpInside)
                               
    }
    
    @objc func postButtonDidTap() {
        guard let model = model else {
            return
        }
        self.delegate?.didTapRelatedPostButton(model: model)
    }
    
    public func configure(with model: UserNotification) {
        self.model = model
        
        
        switch model.type {
        case .like(let post):
            
            let thubmNailPicture = post.thumbnailImage
            guard !thubmNailPicture.absoluteString.contains("google.com") else {return}
            postButton.sd_setBackgroundImage(with: thubmNailPicture, for: .normal, completed: nil)
        case .follow:
            break
        }
        label.text = model.text
        photoImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postButton.setBackgroundImage(nil, for: .normal)
        label.text = nil
        photoImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        photoImageView.frame = CGRect(x: 3, y: 3, width: contentView.height-6, height: contentView.height-6)
        photoImageView.layer.cornerRadius = photoImageView.height/2
        
        let size = contentView.height-4
        
        postButton.frame = CGRect(x: contentView.width-size-5, y: 2, width: size, height: size)
        label.frame = CGRect(x: photoImageView.right + 5, y: 0, width: contentView.width-size-photoImageView.width-16, height: contentView.height)
        
    }

    
}
