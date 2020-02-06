//
//  PhotosAPIClient.swift
//  WeatherApp
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation
import NetworkHelper

struct PhotoApiClient {
    
    static func getPhotos(searchQuery: String, completion: @escaping (Result<[Photo], AppError>)-> ()) {
        
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "Canada"
        
        let endpoint = "https://pixabay.com/api/?key=\(SecretsKey.pixabayApiKey)&q=\(searchQuery)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    
                    let results = try JSONDecoder().decode(PhotoSearch.self, from: data)
                    let photos = results.hits
                    completion(.success(photos))
                    
                } catch {
                    
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
}
