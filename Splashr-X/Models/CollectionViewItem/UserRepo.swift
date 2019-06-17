//
//  UserRepo.swift
//  Splashr-X
//
//  Created by Gino on 18.06.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

struct UserRepo {
  
  private let unsplash: HTTPNetworking<Unsplash>
  
  init(unsplash: HTTPNetworking<Unsplash> = HTTPNetworking<Unsplash>()) {
    self.unsplash = unsplash
  }

  func getMe(completion: @escaping ((Result<User, Error>) -> Void)) {
    
    guard UserSession.accessToken != nil else {
      completion(Result.failure(NonPublicScopeError.noAccessToken))
      return
    }
    
    unsplash.request(.getMe) { (response) in
      switch response {
      case let .success(value):
        do {
          let user = try value.map(to: User.self)
          completion(Result.success(user))
        }
        catch {
          // Decoding error
          completion(Result.failure(error))
        }
      // Networking error
      case let .error(error):
        completion(Result.failure(error))
      }
    }
  }
}
