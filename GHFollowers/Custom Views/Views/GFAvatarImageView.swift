//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Oscar Martinez on 7/31/20.
//  Copyright © 2020 oscmg. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let cache            = NetworkManager.shared.cache
    let placeHolderImage = UIImage(named: "avatar-placeholder")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func downloadImage(from urlString: String) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else { return }
            
            self.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async { self.image = image }
        }
        
        task.resume()
    }
}
