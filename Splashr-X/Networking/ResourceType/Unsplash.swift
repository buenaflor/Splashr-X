//
//  Unsplash.swift
//  Splashr-X
//
//  Created by Gino on 27.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

enum NonPublicScopeError: Error {
  case noAccessToken
  case error(withMessage: String)
}

enum Unsplash {
  
  /// Get a list of all collections
  case collections(
    page: Int?,
    photosPerPage: Int?)
  
  /// Get the list of all photos
  case photos(
    page: Int?,
    perPage: Int?,
    orderBy: OrderBy?)
  
  /// List a user’s collections
  case userCollections(
    username:String,
    page: Int?,
    perPage: Int?)
  
  /// Like a photo as a logged-in user
  case likePhoto(id: String)
  
  /// Remove a user’s like of a photo.
  case unlikePhoto(id: String)
}

extension Unsplash: ResourceType {
  
  var baseURL: URL {
    guard let url = URL(string: "https://api.unsplash.com/") else {
      // should handle this case better
      fatalError("URL doesn't work")
    }
    return url
  }
  
  var endpoint: Endpoint {
    switch self {
    case .collections:
      return .get(path: "/collections")
    case let .userCollections(param):
      return .get(path: "/users/\(param.username)/collections")
    case .photos:
      return .get(path: "/photos")
    case .likePhoto(let id):
      return .post(path: "/photos/\(id)/like")
    case let .unlikePhoto(id):
      return .delete(path: "/photos/\(id)/like")
    }
  }
  
  var task: Task {
    switch self {
    case let .collections(pageNumber, photosPerPage),
         let .userCollections(_, page: pageNumber, perPage: photosPerPage):
      
      var params: [String: Any] = [:]
      params["page"] = pageNumber
      params["per_page"] = photosPerPage
      
      return .requestWithParameters(params, encoding: URLEncoding())
    
    case let .photos(page: pageNumber, perPage: photosPerPage, orderBy: orderBy):
      
      var params: [String: Any] = [:]
      params["page"] = pageNumber
      params["per_page"] = photosPerPage
      params["order_by"] = orderBy
      
      return .requestWithParameters(params, encoding: URLEncoding())
    default:
      return .requestWithParameters([:], encoding: URLEncoding())
    }
  }
  
  var headers: [String : String] {
    let clientID = Configuration.UnsplashSettings.clientID
    guard let accessToken = UserSession.accessToken else {
      return ["Authorization": "Client-ID \(clientID)"]
    }
    return ["Authorization": "Bearer \(accessToken)"]
  }
}

enum OrderBy: String {
  case latest
  case oldest
  case popular
}
