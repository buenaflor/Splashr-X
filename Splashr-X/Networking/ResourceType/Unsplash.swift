//
//  Unsplash.swift
//  Splashr-X
//
//  Created by Gino on 27.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

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
    case .photos:
      return .get(path: "/photos")
    }
  }
  
  var task: Task {
    switch self {
    case let .collections(pageNumber, photosPerPage):
      
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
    }
  }
  
  var headers: [String : String] {
    return [
      "Authorization": "Client-ID \(Configuration.UnsplashSettings.clientID)"
    ]
  }
}

enum OrderBy: String {
  case latest
  case oldest
  case popular
}
