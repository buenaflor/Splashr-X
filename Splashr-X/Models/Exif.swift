//
//  Exif.swift
//  Splashr
//
//  Created by Giancarlo Buenaflor on 03.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

struct Exif: Codable {
  let aperture: String?
  let exposureTime: String?
  let focalLength: String?
  let iso: Int?
  let make: String?
  let model: String?
  
  enum CodingKeys: String, CodingKey {
    case aperture
    case exposureTime = "exposure_time"
    case focalLength = "focal_length"
    case iso
    case make
    case model
  }
}
