//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation
import NetworkHelper

struct WeatherAPIClient {
    static func getWeatherInfo(lat: Double, long: Double, completion: @escaping (Result<Weather, AppError>)-> ()) {


        let endpoint = "https://api.darksky.net/forecast/\(SecretsKey.weatherApiKey)/\(lat),\(long)"

        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        // make a request
        let request = URLRequest(url: url) // this is what is passed to URLSession in network helper

        NetworkHelper.shared.performDataTask(with: request) { (result) in
            // result is either data or an error
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                 // use model to Parse data
                do {
                    let weatherData = try JSONDecoder().decode(Weather.self, from: data)
                    completion(.success(weatherData))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }

    }

    
//    static func getWeatherInfo(filename: String, ext: String) -> Weather{
//              let data = Bundle.readRawjSONData(filename: filename, ext: ext)
//          var weatherData = Weather(from: Decoder)
//              do{
//                  let weather = try JSONDecoder().decode(Weather.self, from: data)
//                  weather = weatherData
//              } catch{
//                  fatalError("decoding error \(error)")
//              }
//              return weatherData
//          }
    
}
