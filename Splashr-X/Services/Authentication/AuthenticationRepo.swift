//
//  AuthenticationRepo.swift
//  Splashr-X
//
//  Created by Gino on 01.06.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation
import AuthenticationServices

protocol AuthenticationRepoType {
  var receivedAccessTokenHandler: ((Error?) -> Void)? { get set }
  func authenticate()
}

class AuthenticationRepo: AuthenticationRepoType {
  
  var receivedAccessTokenHandler: ((Error?) -> Void)?
  
  private var _authSession: Any?
  private var authSession: ASWebAuthenticationSession? {
    get {
      return _authSession as? ASWebAuthenticationSession
    }
    set {
      _authSession = newValue
    }
  }

  private let authManager: UnsplashAuthenticationManager
  
  init(authManager: UnsplashAuthenticationManager = .shared) {
    self.authManager = authManager
    authManager.delegate = self
  }
  
  func authenticate() {
    let authURL = authManager.authURL
    let callbackURLScheme = Configuration.UnsplashSettings.callbackURLScheme
    
    let authSessionHandler: ((URL?, Error?) -> Void) = { [weak self] callbackURL, error in
      guard error == nil, let callbackURL = callbackURL else {
        switch error {
        case ASWebAuthenticationSessionError.canceledLogin?: break
        default: fatalError()
        }
        return
      }
      self?.authManager.receivedCodeRedirect(url: callbackURL)
    }
    
    authSession = ASWebAuthenticationSession(url: authURL,
                                             callbackURLScheme: callbackURLScheme,
                                             completionHandler: authSessionHandler)
    authSession?.start()
  }
}

extension AuthenticationRepo: UnsplashSessionListener {
  func didReceiveRedirect(code: String) {
    self.authManager.accessToken(with: code) { [weak self] _, error in
      self?.receivedAccessTokenHandler?(error)
    }
  }
}
