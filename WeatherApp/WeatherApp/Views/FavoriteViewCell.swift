//
//  FaoriteViewCell.swift
//  WeatherApp
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class FavoriteViewCell: UICollectionViewCell {
   
    @IBOutlet weak var favImage: UIImageView!
    
    public func configureFavCell(photo: Photo) {
            
            favImage.getImage(with: photo.largeImageURL) { [weak self] (result) in
                switch result {
                case .failure(let appError):
                    print(appError)
                    DispatchQueue.main.async {
     self?.favImage.image = UIImage(systemName: "heart")
                    }
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.favImage.image = image
                    }
                }
            }
            
        }
    }

