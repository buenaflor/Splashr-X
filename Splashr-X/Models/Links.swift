//
//  Links.swift
//  Splashr
//
//  Created by Giancarlo Buenaflor on 03.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

struct Link: Decodable {
  let url: String?
  
  enum CodingKeys: String, CodingKey {
    case url
  }
}

struct Links: Codable {
  let selfLink: String?
  let html: String?
  let photos: String?
  let likes: String?
  let portfolio: String?
  let download: String?
  let downloadLocation: String?
  
  enum CodingKeys: String, CodingKey {
    case selfLink = "self"
    case html
    case photos
    case likes
    case portfolio
    case download
    case downloadLocation = "download_location"
  }
}
