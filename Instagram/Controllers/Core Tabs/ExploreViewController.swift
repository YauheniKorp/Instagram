//
//  ExploreViewController.swift
//  Instagram
//
//  Created by Admin on 23.01.2022.
//

import UIKit

class ExploreViewController: UIViewController {

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = .clear
        return searchBar
    }()
    
    private var tabbedSearchCollectionView: UICollectionView?
    
    private var dimmedView: UIView = {
        let dimmedView = UIView()
        dimmedView.backgroundColor = .black
        dimmedView.isHidden = true
        dimmedView.alpha = 0.0
        return dimmedView
    }()
    
    private var models = [UserPost]()
    
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        configureSearchBar()
        configureCollectionView()
        configureTabbedSearch()
        configureGesture()
     
    }
    
    private func configureTabbedSearch() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.width/3, height: 52)
        layout.scrollDirection = .horizontal
        tabbedSearchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tabbedSearchCollectionView?.isHidden = true
        tabbedSearchCollectionView?.backgroundColor = .systemYellow
        tabbedSearchCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        guard let tabbedSearchCollectionView = tabbedSearchCollectionView else {return}
        tabbedSearchCollectionView.delegate = self
        tabbedSearchCollectionView.dataSource = self
        view.addSubview(tabbedSearchCollectionView)
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (view.width-4)/3, height: (view.width-4)/3)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
    }
    
    private func configureGesture() {
        view.addSubview(dimmedView)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(cancelButtonDidTap))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        dimmedView.addGestureRecognizer(gesture)
    }
    
    private func configureSearchBar() {
        navigationController?.navigationBar.topItem?.titleView = searchBar
        searchBar.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView?.frame = view.bounds
        dimmedView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.height)
        tabbedSearchCollectionView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: 72)
    }

}

extension ExploreViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        cancelButtonDidTap()
        guard let text = searchBar.text else {
            return
            
        }
        query(text)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonDidTap))
        dimmedView.isHidden = false
        UIView.animate(withDuration: 0.2, animations: {
            self.dimmedView.alpha = 0.4
        }) { done in
            if done {
                self.tabbedSearchCollectionView?.isHidden = false
            }
        }
    }
    
    @objc private func cancelButtonDidTap() {
        searchBar.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
        self.tabbedSearchCollectionView?.isHidden = true

        UIView.animate(withDuration: 0.2) {
            self.dimmedView.alpha = 0
        } completion: { done in
            if done {
                self.dimmedView.isHidden = true
            }
        }

        
    }
    
    private func query(_ text: String) {
        
    }
}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tabbedSearchCollectionView {
            return 1
        }
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tabbedSearchCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            return cell
                    
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
            
        }
        cell.configure("moun")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        collectionView.deselectItem(at: indexPath, animated: true)
        let user = User(username: "zhenya", bio: "", name: ("",""), birthDate: Date(), profilePhoto: URL(string: "https://www.google.com/")!, gender: .male, counts: UserCount(followers: 1, following: 1, posts: 1), joinDate: Date())
        let post = UserPost(identifier: "", thumbnailImage: URL(string: "https://www.google.com/")!, postURL: URL(string: "https://www.google.com/")!, caption: "", likeCount: [], comments: [], createdDate: Date(), postType: .photo, taggedUsers: [], owner: user)
        let vc = PostViewController(model: post)
        vc.title = post.postType.rawValue
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
