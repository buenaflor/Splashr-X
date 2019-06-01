//
//  UnsplashAuthError.swift
//  Splashr-X
//
//  Created by Gino on 01.06.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

struct UnsplashAuthError: Decodable {
  
  let error: String
  let errorDescription: String
  
  enum CodingKeys: String, CodingKey {
    case error
    case errorDescription = "error_description"
  }
}
