//
//  Response.swift
//  TinyNetworkingExample
//
//  Created by Gino on 11.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

public class Response {
  public let urlRequest: URLRequest
  public let data: Data
  
  public init(urlRequest: URLRequest, data: Data) {
    self.urlRequest = urlRequest
    self.data = data
  }
  
  public func map<T>(to type: T.Type) throws -> T where T : Decodable {
    do {
      return try JSONDecoder().decode(type, from: data)
    } catch(let error) {
      throw HTTPNetworkingError.decodingFailed(error)
    }
  }
}
