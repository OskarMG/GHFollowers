//
//  UIHelper.swift
//  GHFollowers
//
//  Created by Oscar Martinez on 8/7/20.
//  Copyright © 2020 oscmg. All rights reserved.
//

import UIKit

struct UIHelper {
    
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimunItemSpace: CGFloat   = 10
        let availableWidth              = width - (padding * 2) - (minimunItemSpace * 2)
        let itemWidth                   = availableWidth / 3
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
}
