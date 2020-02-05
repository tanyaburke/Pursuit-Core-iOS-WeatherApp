//
//  PhotoModel.swift
//  WeatherApp
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation


struct PhotoSearch:Codable {
    let hits: [Photo]
}

struct Photo: Codable & Equatable{
    let largeImageURL: String
}
