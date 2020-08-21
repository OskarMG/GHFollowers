//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Oscar Martinez on 8/17/20.
//  Copyright © 2020 oscmg. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didTapGitHubProfile(for user: User)
    func didTabGetFollower(for user: User)
}

class UserInfoVC: UIViewController {
    
    let headerView      = UIView()
    let itemViewOne     = UIView()
    let itemViewTwo     = UIView()
    let dateLabel       = GFBodyLabel(textAlignment: .center)
    var itemViews       = [UIView]()
    
    var username:       String!
    weak var delegate:  FollowerListVCDelegate!
    
    init(login: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = login
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layoutUI()
        getUserInfo()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    private func configure() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func layoutUI() {
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        let padding: CGFloat     = 20
        let itemHeight: CGFloat  = 140
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.leadingAnchor,  constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(width: user) }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Ups somthing went wrong 😅", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureUIElements(width user: User) {
        let repoItemVC          = GFRepoItemVC(user: user)
        repoItemVC.delegate     = self
        
        let followerInfoVC      = GFFollowerInfoVC(user: user)
        followerInfoVC.delegate = self
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerInfoVC, to: self.itemViewTwo)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToDisplayFormat())"
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }

}


extension UserInfoVC: UserInfoVCDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "Url attached to this user is invalid.", buttonTitle: "Ok")
            return
        }
        
        self.presentSafariVC(width: url)
    }
    
    func didTabGetFollower(for user: User) {
        
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No followers", message: "This user has not followers. 😔", buttonTitle: "Ok")
            return
        }
        
        dismissVC()
        delegate.didRequestFollower(for: user.login)
    }
}
