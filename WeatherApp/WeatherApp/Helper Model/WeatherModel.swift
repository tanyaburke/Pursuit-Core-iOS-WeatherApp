//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Tanya Burke on 1/31/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

struct Weather : Codable {
    var latitude: Double
    var longitude: Double
    let timezone: String
    let daily: Daily
    let hourly: Hourly
}
struct Daily: Codable {
    let summary: String
    let data: [DailyForecast]
}

struct Hourly: Codable {
    let summary: String
    let data: [HourlyForcast]
    
}

struct HourlyForcast: Codable {
    let summary: String
    let temperature: Double
    let icon: String
}


struct DailyForecast: Codable {
    let summary: String?
    let time: Int
    let icon: String?
    let sunriseTime: Int
    let sunsetTime: Int
    let precipProbability: Double
    let precipType: String?
    let temperatureHigh: Double
    let temperatureLow: Double
    let windSpeed: Double
}
