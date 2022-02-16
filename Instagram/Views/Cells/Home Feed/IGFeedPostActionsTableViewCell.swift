//
//  IGFeedPostActionsTableViewCell.swift
//  Instagram
//
//  Created by Admin on 03.02.2022.
//

import UIKit

protocol IGFeedPostActionsTableViewCellDelegate: AnyObject {
    func didTapLikeButton()
    func didTapCommentButton()
    func didTapSendButton()

    
}

class IGFeedPostActionsTableViewCell: UITableViewCell {

    static let identifier = "IGFeedPostActionsTableViewCell"
    
    weak var delegate: IGFeedPostActionsTableViewCellDelegate?
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "heart", withConfiguration: config)
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "message", withConfiguration: config)
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
        let image = UIImage(systemName: "paperplane", withConfiguration: config)
        button.setImage(image, for: .normal)
        return button
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(sendButton)
        
        likeButton.addTarget(self, action: #selector(likeButtonDidTap), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(commentButtonDidTap), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(sendButtonDidTap), for: .touchUpInside)

    }
    
    @objc private func likeButtonDidTap() {
        delegate?.didTapLikeButton()
    }
    
    @objc private func commentButtonDidTap() {
        delegate?.didTapCommentButton()
    }
    
    @objc private func sendButtonDidTap() {
        delegate?.didTapSendButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserPost) {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonSize = contentView.height-10
        
        let buttons = [likeButton,commentButton,sendButton]
        
        for x in 0..<buttons.count {
            let button = buttons[x]
            button.frame = CGRect(x: (CGFloat(x) * buttonSize) + (10*CGFloat(x+1)), y: 5, width: buttonSize, height: buttonSize)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
