//
//  HTTPNetworkingType.swift
//  TinyNetworkingExample
//
//  Created by Gino on 11.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

public protocol HTTPNetworkingType {
  
  associatedtype Resource
    
  func request(
    _ resource: Resource,
    queue: DispatchQueue,
    completion: @escaping (HTTPNetworkingResult<Response>) -> Void
    ) -> URLSessionDataTask
  
}
