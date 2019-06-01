//
//  UnsplashAuthorization.swift
//  Splashr-X
//
//  Created by Gino on 01.06.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

protocol UnsplashSessionListener: class {
  func didReceiveRedirect(code: String)
}

enum UnsplashAuthorization: ResourceType {
  
  case accessToken(withCode: String)
  
  var baseURL: URL {
    guard let url = URL(string: "https://unsplash.com") else {
      fatalError("FAILED: https://unsplash.com")
    }
    return url
  }
  
  var endpoint: Endpoint {
    return .post(path: "/oauth/token")
  }
  
  var task: Task {
    switch self {
    case let .accessToken(withCode: code):
      var params: [String: Any] = [:]
      
      params["grant_type"] = "authorization_code"
      params["client_id"] = Configuration.UnsplashSettings.clientID
      params["client_secret"] = Configuration.UnsplashSettings.clientSecret
      params["redirect_uri"] = Configuration.UnsplashSettings.redirectURL
      params["code"] = code
      
      return .requestWithParameters(params, encoding: URLEncoding())
    }
  }
  
  var headers: [String : String] {
    return [:]
  }
}
