//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Oscar Martinez on 8/20/20.
//  Copyright © 2020 oscmg. All rights reserved.
//

import UIKit


class GFFollowerInfoVC: GFItemInfoVC {
    
    override func viewDidLoad(){
        super.viewDidLoad()
        configureItems()
    }
    
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, widthCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, widthCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    
    override func actionButtonTapped() {
        delegate.didTabGetFollower(for: self.user)
    }

}
