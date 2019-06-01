//
//  UnsplashAccessToken.swift
//  Splashr-X
//
//  Created by Gino on 01.06.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

struct UnsplashAccessToken: Decodable {
  let accessToken: String
  let tokenType: String
  let refreshToken: String
  let scope: String
  
  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case tokenType = "token_type"
    case refreshToken = "refresh_token"
    case scope
  }
}
