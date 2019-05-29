//
//  Category.swift
//  Splashr
//
//  Created by Giancarlo Buenaflor on 03.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

struct Category: Codable {
  let id: Int?
  let title: String?
  let photoCount: Int?
  let links: Links?
  
  enum CodingKeys: String, CodingKey {
    case id
    case title = "exposure_time"
    case photoCount = "photo_count"
    case links
  }
}

