//
//  HTTPNetworking.swift
//  TinyNetworkingExample
//
//  Created by Gino on 11.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

public enum HTTPNetworkingResult<T> {
  case success(T)
  case error(HTTPNetworkingError)
}

public typealias StatusCode = Int

public enum HTTPNetworkingError: Error {
  case error(Error?)
  case emptyResult
  case decodingFailed(Error?)
  case noHttpResponse
  case requestFailed(Data, HTTPStatusCodes)
}

public class HTTPNetworking<Resource: ResourceType>: NSObject, HTTPNetworkingType, URLSessionTaskDelegate {

  var isWaitingForConnectivityHandler: ((URLSession, URLSessionTask) -> Void)?

  private var session: HTTPNetworkingSession!
  private let manager = URLSessionManager.shared

  public override init() {
    super.init()
    manager.taskDelegate = self
    session = manager.session
  }
  
  @discardableResult
  public func request(
    _ resource: Resource,
    queue: DispatchQueue = .global(qos: .utility),
    completion: @escaping (HTTPNetworkingResult<Response>) -> Void) -> URLSessionDataTask {
    let request = URLRequest(resource: resource)
    
    return session.loadData(with: request, queue: queue) { data, response, error in
      guard error == nil else {
        completion(.error(.error(error)))
        return
      }
      guard let data = data else {
        completion(.error(.emptyResult))
        return
      }
      guard let response = response as? HTTPURLResponse else {
        completion(.error(.noHttpResponse))
        return
      }
      guard 200..<300 ~= response.statusCode else {
        if let statusCode = HTTPStatusCodes(rawValue: response.statusCode) {
          completion(.error(.requestFailed(data, statusCode)))
        } else {
          completion(.error(.requestFailed(data, .Unknown)))
        }
        return
      }
      completion(.success(Response(urlRequest: request, data: data)))
    }
    
  }
  
  public func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) {
    isWaitingForConnectivityHandler?(session, task)
  }
}
