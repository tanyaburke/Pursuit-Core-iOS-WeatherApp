//
//  WeatherTabController.swift
//  WeatherApp
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class WeatherTabController: UITabBarController {

     private lazy var forcastVC: ForcastController = {
            let vc = ForcastController()
            vc.tabBarItem = UITabBarItem(title: "Weather", image: UIImage(systemName: "cloud.sun"), tag: 0)
            return vc
        }()
        
        private lazy var favVC: FavoritesController = {
            let vc = FavoritesController()
            vc.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), tag: 1)
            return vc
        }()
        
//        private lazy var detailVC: WeatherDetailViewController = {
//            let vc = WeatherDetailViewController()
//            vc.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), tag: 2)
//            return vc
//        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            let controllers  = [forcastVC, favVC]
            

          
        }
        


    }
