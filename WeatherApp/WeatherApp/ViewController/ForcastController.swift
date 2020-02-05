//
//  ViewController.swift
//  WeatherApp
//
//  Created by David Rifkin on 10/8/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import UIKit
import MapKit

//- A Label that names the city for the forecast
//- A CollectionView to show the forecasts
//- A TextField for the user to enter the zip code
//
//Selecting a collection view cell should segue to a weather detail view controller



class ForcastController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cityName: UILabel!
    
    @IBOutlet weak var zipcodeTextFeild: UITextField!
   
    
       public var cityPhotos = [Photo]()
       
       
       private var weeksForcast = [DailyForecast]() {
           didSet {
               DispatchQueue.main.async {
                   self.collectionView.reloadData()
               }
           }
       }
       
       
       private var zipCode = "10012" {
           didSet {
              
               UserDefaults.standard.set(zipCode, forKey: "zipCode")
               
               getCityWeather(zipCode: zipCode)
           }
       }
    
     
        
        override func viewDidLoad() {
            super.viewDidLoad()
           
            zipcodeTextFeild.delegate = self
            collectionView.dataSource = self
            collectionView.delegate = self
            
            
            guard let zipCode = UserDefaults.standard.object(forKey: "zipCode") as? String else {
                return
            }
            
            zipcodeTextFeild.text = zipCode
            getCityWeather(zipCode: zipCode)
            
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.title = "     Todays Weather"
            view.backgroundColor = .yellow
            

           
        }
        
        private func getCityWeather(zipCode: String) {
            ZipCodeHelper.getLatLong(fromZipCode: zipCode) { [weak self] (results) in
                switch results {
                case .success(let location):

                    self!.getWeather(lat: location.lat, long: location.long)
                    
                case .failure(let error):
                    self?.showAlert(title: "Check Zipcode", message: " please try again")
                    self?.zipcodeTextFeild.text = ""
                    print(error)
                }
            }
        }
        
        private func getWeather(lat: Double, long: Double) {
            WeatherAPIClient.getWeatherInfo(lat: lat, long: long) { [weak self] (result) in
                switch result {
                case .failure(let appError):
                    print(appError)
                case .success(let weather):
                    self?.weeksForcast = weather.daily.data
        
                }
            }
        }
        
        private func getCityPhotos(city: String) {
            PhotoApiClient.getPhotos(searchQuery: city) { [weak self] (result) in
                switch result {
                case .failure(let appError):
                    print("api client error: \(appError)")
                case .success(let photos):
                    self?.cityPhotos = photos
                }
            }
        }
    }

extension ForcastController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        guard let zipcode = textField.text else {
            getCityWeather(zipCode: zipCode)
            return true
        }
        zipCode = zipcode
        
        return false
    }
}


    extension ForcastController: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return weeksForcast.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCell else {
                fatalError("could not downcast weatherCell")
            }
            
            let weather = weeksForcast[indexPath.row]
            cell.configureWeatherCell(dayWeather: weather)
//            cell.weatherImage.image = UIImage(named: weather.icon)
//            cell.forcastLabel.text = weather.summary
            cell.backgroundColor = .orange
            return cell
        }
    }

    extension ForcastController: UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            
            let interItemSpacing: CGFloat = 10 // space betweem items
            let maxWidth = UIScreen.main.bounds.size.width // device width
            
            let numberOfItems: CGFloat = 1 // items
            let totalSpacing: CGFloat = numberOfItems * interItemSpacing
            
            let itemWidth: CGFloat = (maxWidth - totalSpacing)/numberOfItems
            
            return CGSize(width: itemWidth, height: itemWidth * 1.2)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            // padding sround collectionview
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
            // get instance of storyboard
            
            let detailStoryBoard = UIStoryboard(name: "WeatherDetail", bundle: nil) 
            
            guard let detailVC = detailStoryBoard.instantiateViewController(identifier: "WeatherDetailViewController") as? WeatherDetailViewController else {
                fatalError("could not downcast to DetailController")
            }
            
            
            if  cityPhotos.count != 0 {
                detailVC.photo = cityPhotos[indexPath.row]
            }
            
            detailVC.weather = weeksForcast[indexPath.row]
            detailVC.cityName = cityName.text
            
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }

    

