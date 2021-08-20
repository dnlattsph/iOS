//
//  CacheManager.swift
//  NewsApp
//
//  Created by D Naung Latt on 19/08/2021.
//

import Foundation
 

class CacheManager {
    
    static var imageDictionary = [String:Data]()
    
    static func saveData(_ url:String, _ imageData:Data) {
        
        // Save the image Data along with the URL
        
        imageDictionary[url] = imageData
    }
    
    static func retrieveData(_ url:String) -> Data? {
        
        // Return the saved image data or nil
        
        return imageDictionary[url]
    }
}


