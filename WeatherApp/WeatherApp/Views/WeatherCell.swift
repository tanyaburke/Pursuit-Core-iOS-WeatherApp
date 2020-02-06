//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    

    
    @IBOutlet weak var forcastLabel: UILabel!
    
    @IBOutlet weak var weatherImage: UIImageView!
    

      public func configureWeatherCell(dayWeather: DailyForecast) {

        weatherImage?.image = UIImage(named: (dayWeather.icon ??  "clear-day") )
        forcastLabel.text = "High:\(dayWeather.temperatureHigh.description)\n  Low:\(dayWeather.temperatureLow.description)"
     
        }

        
        
        
    }
    

