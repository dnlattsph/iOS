//
//  VideoModel.swift
//  Africa
//
//  Created by D Naung Latt on 07/07/2021.
//

import Foundation

struct Video: Codable, Identifiable {
  let id: String
  let name: String
  let headline: String
  
  // Computed Property
  var thumbnail: String {
    "video-\(id)"
  }
}
