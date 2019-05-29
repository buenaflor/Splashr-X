//
//  ImageURLs.swift
//  Splashr
//
//  Created by Giancarlo Buenaflor on 03.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

struct ImageURLs: Codable {
  let full: String?
  let raw: String?
  let regular: String?
  let small: String?
  let thumb: String?
  
  enum CodingKeys: String, CodingKey {
    case full
    case raw
    case regular
    case small
    case thumb
  }
}
