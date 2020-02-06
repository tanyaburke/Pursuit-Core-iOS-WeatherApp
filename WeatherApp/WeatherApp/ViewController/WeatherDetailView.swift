//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class WeatherDetailView: UIView {

        
        public lazy var todayLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.light)
            label.text = "Today's Forcast"
            return label
           }()
        
        public lazy var weatherLabel: UILabel = {
             let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 20)
            label.numberOfLines = 6
             label.text = "Summary goes here"
             return label
        }()
   
    public lazy var favButton: UIButton = {
        let button = UIButton()
        button.setTitle("FavImage", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.backgroundColor = .gray
        button.isEnabled = Bool()
//        button.touchesBegan(<#T##touches: Set<UITouch>##Set<UITouch>#>, with: .<#T##UIEvent?#>)
        return button
    }()
        
        public lazy var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.backgroundColor = .yellow
            return imageView
        }()
        
      
        
        override init(frame: CGRect) {
            super.init(frame: UIScreen.main.bounds)
            commonInit()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            commonInit()
        }
        
        private func commonInit() {
           
            setUpImageViewConstraints()
            setuptodayLabelConstraints()
            setupWeatherLabelConstraints()
           
        }
         
    func favButtonSetup(){
        
    }
   
        func setUpImageViewConstraints() {
           
            addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
                imageView.heightAnchor.constraint(equalToConstant: 220),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            ])
            
        }
        
       
     
        private func setuptodayLabelConstraints() {
            addSubview(todayLabel)
            todayLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                todayLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
                todayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                todayLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            ])
        }
        
        private func setupWeatherLabelConstraints() {
            addSubview(weatherLabel)
            weatherLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                weatherLabel.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 20),
                weatherLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                weatherLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            ])
        }
        
    func setupfavButtonConstraints(){
           addSubview(favButton)
           favButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
           favButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            favButton.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 10),
//            favButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            favButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20)
        
        
        
        ])
           
       }
       

}
