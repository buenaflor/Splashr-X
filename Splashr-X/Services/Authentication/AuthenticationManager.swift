//
//  AuthenticationManager.swift
//  Splashr-X
//
//  Created by Gino on 01.06.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

class UnsplashAuthenticationManager {
  
  var delegate: UnsplashSessionListener?
  
  static var shared: UnsplashAuthenticationManager {
    return UnsplashAuthenticationManager(
      clientID: Configuration.UnsplashSettings.clientID,
      clientSecret: Configuration.UnsplashSettings.clientSecret,
      scopes: Scope.allCases
    )
  }
  
  // MARK: Private Properties
  
  private let clientID: String
  private let clientSecret: String
  private let redirectURL: URL
  private let scopes: [Scope]
  private let unplash: HTTPNetworking<UnsplashAuthorization>
  
  // MARK: Public Properties
  
  public var authURL: URL {
    var components = URLComponents()
    components.scheme = "https"
    components.host = Configuration.UnsplashSettings.host
    components.path = "/oauth/authorize"
    
    var params: [String: String] = [:]
    params["response_type"] = "code"
    params["client_id"] = clientID
    params["redirect_uri"] = redirectURL.absoluteString
    params["scope"] = scopes.map { $0.rawValue }.joined(separator: "+")
    
    let url = components.url?.appendingQueryParameters(params, encoding: URLEncoding())
    
    return url!
  }
  
  // MARK: Init
  init(clientID: String,
       clientSecret: String,
       scopes: [Scope] = [Scope.pub],
       unsplash:  HTTPNetworking<UnsplashAuthorization> = HTTPNetworking<UnsplashAuthorization>()) {
    self.clientID = clientID
    self.clientSecret = clientSecret
    self.redirectURL = URL(string: Configuration.UnsplashSettings.redirectURL)!
    self.scopes = scopes
    self.unplash = unsplash
  }
  
  // MARK: Public
  public func receivedCodeRedirect(url: URL) {
    guard let code = extractCode(from: url) else { return }
    delegate?.didReceiveRedirect(code: code)
  }
  
  public func accessToken(with code: String, completion: @escaping (String?, Error?) -> Void) {
    unplash.request(.accessToken(withCode: code)) { [unowned self] response in
      switch response {
      case let .success(result):
        if let accessTokenObject = try? result.map(to: UnsplashAccessToken.self) {
          let token = accessTokenObject.accessToken
          UserDefaults.standard.set(token, forKey: self.clientID)
          completion(token, nil)
        }
      case let .error(error):
        completion(nil, error)
      }
    }
  }
  
  // MARK: Private
  private func accessTokenURL(with code: String) -> URL {
    var components = URLComponents()
    components.scheme = "https"
    components.host = Configuration.UnsplashSettings.host
    components.path = "/oauth/token"
    
    var params: [String: String] = [:]
    params["grant_type"] = "authorization_code"
    params["client_id"] = clientID
    params["client_secret"] = clientSecret
    params["redirect_uri"] = redirectURL.absoluteString
    params["code"] = code
    
    let url = components.url?.appendingQueryParameters(params, encoding: URLEncoding())
    
    return url!
  }
  
  private func extractCode(from url: URL) -> String? {
    return url.value(for: "code")
  }
  
  private func extractErrorDescription(from data: Data) -> String? {
    let error = try? JSONDecoder().decode(UnsplashAuthError.self, from: data)
    return error?.errorDescription
  }
}
