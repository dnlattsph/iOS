//
//  Article.swift
//  NewsApp
//
//  Created by D Naung Latt on 19/08/2021.
//

import Foundation

struct Article : Decodable {
    
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    
}
