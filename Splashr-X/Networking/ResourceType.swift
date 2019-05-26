//
//  ResourceType.swift
//  TinyNetworkingExample
//
//  Created by Gino on 11.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

public protocol ResourceType {
  var baseURL: URL { get }
  var endpoint: Endpoint { get }
  var task: Task { get }
  var headers: [String: String] { get }
}
