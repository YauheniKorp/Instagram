//
//  NotificationsViewController.swift
//  Instagram
//
//  Created by Admin on 23.01.2022.
//

import UIKit

enum UserNotificationType {
    case like(post: UserPost)
    case follow
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: User
}

final class NotificationsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = false
        tableView.register(NotificationLikeEventTableViewCell.self, forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        tableView.register(NotificationFollowEventTableViewCell.self, forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
        return tableView
    }()
    
    private var models = [UserNotification]()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    private lazy var noNotifications = NoNotificationsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
        navigationItem.title = "Notifications"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(spinner)
//        spinner.startAnimating()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    
    private func layoutNoNotifications() {
        tableView.isHidden = true
        view.addSubview(noNotifications)
        noNotifications.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/4)
        noNotifications.center = view.center
    }
    
    private func fetchData() {
        let post = UserPost(identifier: "", thumbnailImage: URL(string: "https://www.google.com/")!, postURL: URL(string: "https://www.google.com/")!, caption: "", likeCount: [], comments: [], createdDate: Date(), postType: .photo, taggedUsers: [])
        for x in 0...100 {
            models.append(UserNotification(type: x % 2 == 0 ? .like(post: post) : .follow, text: "Hello world!", user: User(username: "zhenya", bio: "", name: ("",""), birthDate: Date(), profilePhoto: URL(string: "https://www.google.com/")!, gender: .male, counts: UserCount(followers: 1, following: 1, posts: 1), joinDate: Date())))
        }
    }
}

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type {
        case .like(post: _):
            // create like cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier, for: indexPath) as! NotificationLikeEventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        case .follow:
            //create follow cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier, for: indexPath) as! NotificationFollowEventTableViewCell
            //cell.configure(with: model)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
}

extension NotificationsViewController: NotificationLikeEventTableViewCellDelegate {
    func didTapRelatedPostButton(model: UserNotification) {
        print("liked post")
        // open post
        
    }
}

extension NotificationsViewController: NotificationFollowEventTableViewCellDelegate {
    func followAndUnfollowDidTapp(model: String) {
        print("tapped button")
        // perform database update
    }
}
