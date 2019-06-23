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
  
  /// Get the user's profile
  case getMe
  
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
  
  /// Create a new collection
  case createCollection(
    title: String,
    description: String?,
    isPrivate: Bool?)
  
  /// Update an existing collection
  case updateCollection(
    id: Int,
    title: String?,
    description: String?,
    isPrivate: Bool?)
  
  /// Delete an existing collection
  case deleteCollection(id: Int)
  
  /// Add a photo to a collection
  case addPhotoToCollection(
    collectionID: Int,
    photoID: String)
  
  /// Remove a photo from a collection
  case removePhotoFromCollection(
    collectionID: Int,
    photoID: String)

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
    case .getMe:
      return .get(path: "/me")
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
    case .createCollection:
      return .post(path: "/collections")
    case let .updateCollection(params):
      return .put(path: "/collections\(params.id)")
    case let .deleteCollection(id):
      return .delete(path: "/collections/\(id)")
    case let .addPhotoToCollection(params):
      return .post(path: "/collections/\(params.collectionID)/add")
    case let .removePhotoFromCollection(params):
      return .delete(path: "/collections/\(params.collectionID)/remove")
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
      
    case let .createCollection(value):

      var params: [String: Any] = [:]
      params["title"] = value.title
      params["description"] = value.description
      params["private"] = value.isPrivate
      
      return .requestWithParameters(params, encoding: URLEncoding())
      
    case let .updateCollection(value):
      
      var params: [String: Any] = [:]
      params["title"] = value.title
      params["description"] = value.description
      params["private"] = value.isPrivate
      
      return .requestWithParameters(params, encoding: URLEncoding())
      
    case let .addPhotoToCollection(value),
         let .removePhotoFromCollection(value):
      
      var params: [String: Any] = [:]
      params["photo_id"] = value.photoID
      
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
