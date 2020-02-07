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


//Do the network call for getPhoto

class WeatherDetailViewController: UIViewController {
    
    private var weatherDV = WeatherDetailView()
    
    
    public var photo: Photo?
    public var weather: DailyForecast?
    public var cityName: String?
    
    public let dataPersistence = DataPersistence<Photo>(filename: "favPhotos")
    
    
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
    
    //TODO
    @objc
    private func addFavButton(_ sender: UIButton){
    
        print("AHHHHHHHHHH")
        guard let validPhoto = photo else {
            fatalError("failed to unwrap passed photo")
        }
        if dataPersistence.hasItemBeenSaved(validPhoto) {
            
            weatherDV.favButton.isEnabled = false
            
        }else {
        
        DispatchQueue.main.async {
        
        do {
            try self.dataPersistence.createItem(validPhoto)
            
            self.showAlert(title: "Success", message: "Saved Photo")
        } catch {
            self.showAlert(title: "Failed to save photo", message: "\(error)")
        }
            self.dataPersistence.update(validPhoto, at: 0)
    }
        }
    }
    
    private func checkPhoto() {
        
        guard let photo = photo else {
            weatherDV.favButton.isEnabled = false
            return
        }
        
        if dataPersistence.hasItemBeenSaved(photo) {
                weatherDV.favButton.isEnabled = false
            }
            
            
        }
    
    
    private func updateUI() {
        
        guard let weather = weather, let cityName = cityName else {
            fatalError("couldnt get weather or photo from other VC check segue")
        }
        
        navigationItem.title = cityName
        
        weatherDV.weatherLabel.text = "\(Double(weather.time).convertToDate(dateFormat: "EEEE, MMM d, yyyy"))\n \(weather.summary ?? "unable to retrive forcast") \nHigh:\(weather.temperatureHigh) °F \nLow:\(weather.temperatureLow) °F \nWindSpeed: \(weather.windSpeed) mph \nPercipitationPossiblilty:\(weather.precipProbability)%"
        
     
        PhotoApiClient.getPhotos(searchQuery: cityName) { [weak self] (result) in
            switch result{
            case .success(let photo):
                guard let validPhoto = photo else{
                    return
                }
                DispatchQueue.main.async {
                    
                    
                    self?.weatherDV.imageView.getImage(with: validPhoto.largeImageURL) { [weak self] (result) in
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
            case .failure(let appError):
                self?.showAlert(title: "Error", message: "\(appError)")
            }
        }
        
    }
    
    
    
}

