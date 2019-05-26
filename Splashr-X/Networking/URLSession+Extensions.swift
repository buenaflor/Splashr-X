//
//  URLSession+Extensions.swift
//  TinyNetworkingExample
//
//  Created by Gino on 11.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

public protocol HTTPNetworkingSession {
  typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
  func loadData(
    with urlRequest: URLRequest,
    queue: DispatchQueue,
    completionHandler: @escaping CompletionHandler
    ) -> URLSessionDataTask
}

extension URLSession: HTTPNetworkingSession {
  public func loadData(
    with urlRequest: URLRequest,
    queue: DispatchQueue,
    completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
    let task = dataTask(with: urlRequest) { data, urlResponse, error in
      queue.async { completionHandler(data, urlResponse, error) }
    }
    task.resume()
    return task
  }
}
