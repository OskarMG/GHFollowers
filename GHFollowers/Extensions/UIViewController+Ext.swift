//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Oscar Martinez on 7/28/20.
//  Copyright © 2020 oscmg. All rights reserved.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
    
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            
            self.present(alertVC, animated: true)
        }
    }
    
    
    func presentSafariVC(width url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredBarTintColor = .systemGreen
        DispatchQueue.main.async { self.present(safariVC, animated: true) }
    }
    
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyStateView(message: String, in view: UIView) {
        let emptyStateView      = GFEmptyStateView(message: message)
        emptyStateView.frame    = view.bounds
        view.addSubview(emptyStateView)
    }
    
}
