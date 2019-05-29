//
//  Constants.swift
//  Splashr-X
//
//  Created by Gino on 29.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

struct Configuration {
  struct UnsplashSettings {
    static let callbackURLScheme = "slashr-x://"
    static let clientID = Secrets.clientID
    static let clientSecret = Secrets.clientSecret
    static let authorizeURL = "https://unsplash.com/oauth/authorize"
    static let tokenURL = "https://unsplash.com/oauth/token"
    static let redirectURL = "splashr-x://unsplash"
    
    struct Secrets {
      /// The client id used to identify the client at the server. Sent during
      /// authentication.
      static let clientID: String =
      "d9e824ee950a9a2bde5b55254b00bc1e2dc1e25a4a2007394707ee098ae3018f"
      
      /// The client secret used to identify the client at the server. Sent during
      /// authentication.
      static let clientSecret: String =
      "353b7c87755c67a804cb7f436e9cfaa173dd010d33b097f8a391da41d2e32dbe"
    }
  }
}
