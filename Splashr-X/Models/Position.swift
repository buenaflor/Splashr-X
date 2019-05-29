//
//  Position.swift
//  Splashr
//
//  Created by Giancarlo Buenaflor on 03.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

// MARK: Position

struct Position: Codable {
  let latitude: Double?
  let longitude: Double?
  
  enum CodingKeys: String, CodingKey {
    case latitude
    case longitude
  }
}

// MARK: Location

struct Location: Codable {
  let city: String?
  let country: String?
  let position: Position?
  
  enum CodingKeys: String, CodingKey {
    case city
    case country
    case position
  }
}
