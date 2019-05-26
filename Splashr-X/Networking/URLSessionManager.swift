//
//  URLSessionManager.swift
//  TinyNetworkingExample
//
//  Created by Gino on 16.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

public class URLSessionManager {
  weak var taskDelegate: URLSessionTaskDelegate?
  
  var session: URLSession {
    let configuration = URLSessionConfiguration.default
    configuration.waitsForConnectivity = true
    return URLSession(configuration: configuration, delegate: taskDelegate, delegateQueue: nil)
  }
  
  private init() { }
  
  public static let shared = URLSessionManager()
}
