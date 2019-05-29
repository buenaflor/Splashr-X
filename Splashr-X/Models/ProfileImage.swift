//
//  ProfileImage.swift
//  Splashr
//
//  Created by Giancarlo Buenaflor on 03.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

struct ProfileImage: Codable {
  let small: String?
  let medium: String?
  let large: String?
  
  enum CodingKeys: String, CodingKey {
    case small
    case medium
    case large
  }
}
