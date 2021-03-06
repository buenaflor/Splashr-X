//
//  AnyEncodable.swift
//  TinyNetworkingExample
//
//  Created by Gino on 11.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

struct AnyEncodable: Encodable {
  
  private let encodable: Encodable
  
  public init(_ encodable: Encodable) {
    self.encodable = encodable
  }
  
  func encode(to encoder: Encoder) throws {
    try encodable.encode(to: encoder)
  }
}
