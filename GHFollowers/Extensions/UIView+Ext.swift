//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Oscar Martinez on 9/22/20.
//  Copyright © 2020 oscmg. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
    
}
