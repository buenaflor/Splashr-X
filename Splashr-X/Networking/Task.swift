//
//  Task.swift
//  TinyNetworkingExample
//
//  Created by Gino on 11.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

public enum Task {
  case requestWithParameters([String: Any], encoding: URLEncoding)
  case requestWithEncodable(Encodable)
}
