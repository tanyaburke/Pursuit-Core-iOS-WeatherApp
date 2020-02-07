//
//  FavImagesViewController.swift
//  WeatherApp
//
//  Created by Tanya Burke on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import DataPersistence

//The favorite images view controller should have:
//
//- A table view that contains all of the images that have been favorited.
//
//The image at the top should be the most recently favorited image.

class FavoritesController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    private var favorites = [Photo]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    private let dataPersistence = DataPersistence<Photo>(filename: "favPhotos")
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Favorites"
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        loadfavorties()
    }
    
    
    private func loadfavorties() {
        do {
            self.favorites = try dataPersistence.loadItems()
            
        } catch {
            print("error retreiving photos: \(error)")
        }
    }
}



extension FavoritesController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath) as? FavoriteViewCell else {
            fatalError("could not downcast fav cell")
        }
        let favPic = favorites[indexPath.row]
        cell.configureFavCell(photo: favPic)
        return cell
    }
    
    
}


extension FavoritesController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let interItemSpacing: CGFloat = 10
        let maxWidth = UIScreen.main.bounds.size.width
        
        let numberOfItems: CGFloat = 1
        let totalSpacing: CGFloat = numberOfItems * interItemSpacing
        
        let itemWidth: CGFloat = (maxWidth - totalSpacing)/numberOfItems
        
        return CGSize(width: itemWidth, height: itemWidth * 1.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
//        let detailStoryBoard = UIStoryboard(name: "WeatherDetail", bundle: nil)
//
//        guard let detailVC = detailStoryBoard.instantiateViewController(identifier: "WeatherDetailViewController") as? WeatherDetailViewController else {
//            fatalError("could not downcast to DetailController")
//        }
    
//        if  favorites.count != 0 {
//            detailVC.photo = favorites[indexPath.row]
//        }
//        //                    detailVC.weather = [indexPath.row]
//        navigationController?.pushViewController(detailVC, animated: true)
//    }
}

