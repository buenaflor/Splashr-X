//
//  URL+Extensions.swift
//  TinyNetworkingExample
//
//  Created by Gino on 11.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

extension URL {
  func appendingQueryParameters(_ parameters: [String: Any], encoding: URLEncoding) -> URL {
    var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
    urlComponents.query = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + encoding.query(parameters)
    
    return urlComponents.url!
  }
  
  func value(for queryKey: String) -> String? {
    guard let items = URLComponents(string: absoluteString)?.queryItems else { return nil }
    for item in items where item.name == queryKey {
      return item.value
    }
    return nil
  }
  
}
