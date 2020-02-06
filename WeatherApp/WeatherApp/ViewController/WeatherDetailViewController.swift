//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Tanya Burke on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit
import ImageKit
import DataPersistence
//Do programmaticly
//The weather detail view controller should have:
//
//- A Label naming the city and the forecast date
//- A random image of the city
//- A Label with a longer description of the weather
//- Additional information about the weather including the high, low, sunrise, sunset, windspeed and precipitation
//
//Selecting the "Save" bar button item should save the image to your favorites and present an alert view informing the user.


class WeatherDetailViewController: UIViewController {

        private var weatherDV = WeatherDetailView()

       
        public var photo: Photo?
        public var weather: DailyForecast?
        public var cityName: String?
       
    public let dataPersistance = DataPersistence<Photo>(filename: "favPhotos.plist")
        
        
        override func viewDidLayoutSubviews() {
           
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()

            updateUI()
            checkPhoto()
            view.backgroundColor = .white
            weatherDV.favButton.addTarget(self, action: #selector(addFavButton(_:)), for: .touchUpInside)
        }
       
        override func loadView() {
            view = weatherDV
        }
        
        
        @objc
        private func addFavButton(_ sender: UIButton){
            print("AHHHHHHHHHH")
        }
        
        private func checkPhoto() {
        
            guard let photo = photo else {
                weatherDV.favButton.isEnabled = false
                return
            }
            
            do {
                let favs = try dataPersistance.loadItems()
                if favs.contains(photo) {
                    weatherDV.favButton.isEnabled = false
                }
            } catch {
                print("error geting favs on detail vc")
            }
            
            
        }
        
        private func updateUI() {
            
            guard let weather = weather, let cityName = cityName else {
                fatalError("couldnt get weather or photo from other VC check segue")
            }
         
           navigationItem.title = cityName
            
            weatherDV.weatherLabel.text = "\(Double(weather.time).convertToDate(dateFormat: "EEEE, MMM d, yyyy"))/n \(String(describing: weather.summary)) \nHigh:\(weather.temperatureHigh) °F \nLow:\(weather.temperatureLow) °F \nWindSpeed: \(weather.windSpeed) mph \nPercipitationPossiblilty:\(weather.precipProbability)%"
            
            guard let photo = photo else {
                DispatchQueue.main.async {
                    self.weatherDV.imageView.image = UIImage(named: "newYork")
                }
                return
            }
            
            weatherDV.imageView.getImage(with: photo.largeImageURL) { [weak self] (result) in
                switch result {
                case .failure(let appError):
                    print(appError)
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.weatherDV.imageView.image = image
                    }
                }
            }
        }
        
        
        
    }

