//
//  FavoritesVC.swift
//  GHFollowers
//
//  Created by Oscar Martinez on 7/24/20.
//  Copyright © 2020 oscmg. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBlue
        
        
        PersistenceManager.retrieveFavorites { (result) in
            
            switch result {
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
            
        }
    }
    

}
