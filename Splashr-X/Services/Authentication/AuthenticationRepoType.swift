//
//  AuthenticationRepoType.swift
//  Splashr-X
//
//  Created by Gino on 02.06.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

protocol AuthenticationRepoType {
  var receivedAccessTokenHandler: ((Error?) -> Void)? { get set }
  func authenticate()
}
