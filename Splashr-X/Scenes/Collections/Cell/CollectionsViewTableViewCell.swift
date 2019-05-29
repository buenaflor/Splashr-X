//
//  CollectionsTableViewCell.swift
//  Splashr-X
//
//  Created by Gino on 28.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

class CollectionsViewTableViewCell: UITableViewCell, NibIdentifiable & ClassIdentifiable {
  
  @IBOutlet weak var coverImageView: UIImageView! {
    didSet {
      coverImageView.contentMode = .scaleAspectFill
    }
  }
  
}

extension URL {
  func appending(queryItems: [URLQueryItem]) -> URL {
    guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
      return self
    }
    
    var queryDictionary = [String: String]()
    if let queryItems = components.queryItems {
      for item in queryItems {
        queryDictionary[item.name] = item.value
      }
    }
    
    for item in queryItems {
      queryDictionary[item.name] = item.value
    }
    
    var newComponents = components
    newComponents.queryItems = queryDictionary.map({ URLQueryItem(name: $0.key, value: $0.value) })
    
    return newComponents.url ?? self
  }
}
