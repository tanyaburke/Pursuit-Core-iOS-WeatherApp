//
//  Bundle+Extension.swift
//  WeatherApp
//
//  Created by Tanya Burke on 2/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import Foundation

extension Bundle {
    static func readRawjSONData(filename: String, ext: String) -> Data{
        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: ext) else {
            fatalError("resource with filename \(filename) not found")
        }
        
        var data: Data!
        do{
            data = try Data.init(contentsOf: fileURL)
        }catch{
            fatalError("contents were not found \(error)")
        }
        
        return data
    }
}
