//
//  ArticleService.swift
//  NewsApp
//
//  Created by D Naung Latt on 19/08/2021.
//

import Foundation

struct ArticleService: Decodable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
    
}
