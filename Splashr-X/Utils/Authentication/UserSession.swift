//
//  UserSession.swift
//  Splashr-X
//
//  Created by Gino on 01.06.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

struct UserSession {
  
  private static let savedUserKey = "SavedUser"
  private static let clientID = Configuration.UnsplashSettings.clientID
  
  static var accessToken: String? {
    return UserDefaults.standard.string(forKey: UserSession.clientID)
  }
  
  static func clearAccessToken() {
    UserDefaults.standard.removeObject(forKey: UserSession.clientID)
  }
  
  static var currentUser: User? {
    let defaults = UserDefaults.standard
    if let savedUser = defaults.object(forKey: savedUserKey) as? Data {
      let decoder = JSONDecoder()
      if let user = try? decoder.decode(User.self, from: savedUser) {
        return user
      }
    }
    return nil
  }
  
  // Is this thread safe?
  static func saveUser(_ user: User, completion: (((Error?) -> Void))? = nil) {
    let encoder = JSONEncoder()
    do {
      let encoded = try encoder.encode(user)
      let defaults = UserDefaults.standard
      defaults.set(encoded, forKey: savedUserKey)
      completion?(nil)
    } catch {
      completion?(error)
    }
  }
  
  static var isLoggedIn: Bool {
    return accessToken != nil && currentUser != nil
  }
}
