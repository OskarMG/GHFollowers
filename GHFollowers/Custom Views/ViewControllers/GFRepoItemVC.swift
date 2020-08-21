//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Oscar Martinez on 8/20/20.
//  Copyright © 2020 oscmg. All rights reserved.
//

import UIKit


class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad(){
        super.viewDidLoad()
        configureItems()
    }
    
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, widthCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, widthCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: self.user)
    }
}
