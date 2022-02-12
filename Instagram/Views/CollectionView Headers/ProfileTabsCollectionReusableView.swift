//
//  ProfileTabsCollectionReusableView.swift
//  Instagram
//
//  Created by Admin on 06.02.2022.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func gridButtonDidTap()
    func tagButtonDidTap()
}

class ProfileTabsCollectionReusableView: UICollectionReusableView {

    static let identifier = "ProfileTabsCollectionReusableView"
    
    struct Constants {
        static let padding: CGFloat = 8.0
    }
    
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    private let gridButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemBlue
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage(systemName: "square.grid.3x3"), for: .normal)
        return button
    }()
    
    private let tagButton: UIButton = {
        let button = UIButton()
        button.tintColor = .lightGray
        button.clipsToBounds = true
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(gridButton)
        addSubview(tagButton)
        gridButton.addTarget(self, action: #selector(gridDidTap), for: .touchUpInside)
        tagButton.addTarget(self, action: #selector(tagDidTap), for: .touchUpInside)

    }
    
    @objc private func gridDidTap() {
        gridButton.tintColor = .systemBlue
        tagButton.tintColor = .lightGray
        delegate?.gridButtonDidTap()
    }
    
    @objc private func tagDidTap() {
        gridButton.tintColor = .lightGray
        tagButton.tintColor = .systemBlue
        delegate?.tagButtonDidTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = height - (Constants.padding * 2)
        
        let gridButtonX = ((width/2)-size)/2
        
        gridButton.frame = CGRect(x: gridButtonX, y: Constants.padding, width: size, height: size)
        tagButton.frame = CGRect(x: gridButtonX + (width/2), y: Constants.padding, width: size, height: size)
    }
}
