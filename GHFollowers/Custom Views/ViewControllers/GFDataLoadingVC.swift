//
//  GFDataLoadingVC.swift
//  GHFollowers
//
//  Created by Oscar Martinez on 9/10/20.
//  Copyright © 2020 oscmg. All rights reserved.
//

import UIKit

class GFDataLoadingVC: UIViewController {
    
    var containerView: UIView!

    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        guard !view.subviews.contains(containerView) else { return }
        
        view.addSubview(containerView)
        
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    func showEmptyStateView(message: String, in view: UIView) {
        guard !view.subviews.contains(view) else { return }
        
        let emptyStateView      = GFEmptyStateView(message: message)
        emptyStateView.frame    = view.bounds
        view.addSubview(emptyStateView)
    }

}
