//
//  ViewController.swift
//  Instagram
//
//  Created by Admin on 23.01.2022.
//

import UIKit
import FirebaseAuth

struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let comments: PostRenderViewModel
    let actions: PostRenderViewModel
}

class HomeViewController: UIViewController {
    
    private var homeRenderModels = [HomeFeedRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        configureModels()
    }
    
    private func configureModels() {
        let user = User(username: "zhenya", bio: "", name: ("",""), birthDate: Date(), profilePhoto: URL(string: "https://www.google.com/")!, gender: .male, counts: UserCount(followers: 1, following: 1, posts: 1), joinDate: Date())
        let post = UserPost(identifier: "", thumbnailImage: URL(string: "https://www.google.com/")!, postURL: URL(string: "https://www.google.com/")!, caption: "", likeCount: [], comments: [], createdDate: Date(), postType: .photo, taggedUsers: [], owner: user)
        var comments = [PostComment]()
        for x in 0..<3 {
            comments.append(PostComment(identifier: "\(x)", username: "@yauheni", text: "The best post I've ever seen!", createdDate: Date(), likes: []))
        }
        
        for x in 0..<6 {
            let model = HomeFeedRenderViewModel(header: PostRenderViewModel(rendertype: .header(provider: user)),
                                                post: PostRenderViewModel(rendertype: .primaryContent(provider: post)),
                                                comments: PostRenderViewModel(rendertype: .comments(provider: comments)),
                                                actions: PostRenderViewModel(rendertype: .actions(provider: "")))
            homeRenderModels.append(model)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkForStatusOfAuth()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func checkForStatusOfAuth() {
        if Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return homeRenderModels.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = homeRenderModels[0]
        } else {
            let position = x % 4 == 0 ? x/4 : ((x-(x % 4))/4)
            model = homeRenderModels[position]
        }
        
        let subsection = x % 4
        
        if subsection == 0 {
            // header
            return 1
        } else if subsection == 1 {
            // post
            return 1
        } else if subsection == 2 {
            // actions
            return 1
        } else if subsection == 3 {
            // comments
            let commetsModel = model.comments
            switch commetsModel.rendertype {
            case .comments(let comments): return comments.count > 2 ? 2 : comments.count
            case .actions, .primaryContent, .header: return 0
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = homeRenderModels[0]
        } else {
            let position = x % 4 == 0 ? x/4 : ((x-(x % 4))/4)
            model = homeRenderModels[position]
        }
        
        let subsection = x % 4
        
        if subsection == 0 {
            // header
            let headerModel = model.header
            
            switch headerModel.rendertype {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
                return cell
            case .actions, .primaryContent, .comments: return UITableViewCell()

            }
            
        } else if subsection == 1 {
            // post
            let postModel = model.post
            
            switch postModel.rendertype {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
                return cell
            case .actions, .comments, .header: return UITableViewCell()

            }
            
        } else if subsection == 2 {
            // actions
            let actionsModel = model.actions
            
            switch actionsModel.rendertype {
            case .actions(let actions):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
                return cell
            case .comments, .primaryContent, .header: return UITableViewCell()

            }
            
        } else if subsection == 3 {
            // comments
            let commentsModel = model.comments
            switch commentsModel.rendertype {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                return cell
            case .actions, .primaryContent, .header: return UITableViewCell()
            }
           
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subsection = indexPath.section % 4
        
        if subsection == 0 {
            return 70
        } else if subsection == 1 {
            return tableView.width
        } else if subsection == 2 {
            return 60
        } else if subsection == 3 {
            return 50
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subsection = section % 4
        return subsection == 3 ? 70 : 0
    }
    
    
    
}
