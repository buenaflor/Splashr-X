//
//  UserSession.swift
//  Splashr-X
//
//  Created by Gino on 01.06.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

struct UserSession {
  
  private static let clientID = Configuration.UnsplashSettings.clientID
  
  static var accessToken: String? {
    return UserDefaults.standard.string(forKey: UserSession.clientID)
  }
  
  static func clearAccessToken() {
    UserDefaults.standard.removeObject(forKey: UserSession.clientID)
  }
  
  static var isLoggedIn: Bool {
    return accessToken != nil
  }
  
}
