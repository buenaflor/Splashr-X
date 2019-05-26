//
//  ClassIdentifiable.swift
//  Splashr
//
//  Created by Giancarlo Buenaflor on 02.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

protocol ClassIdentifiable: class {
  static var reuseId: String { get }
}

extension ClassIdentifiable {
  static var reuseId: String {
    return String(describing: self)
  }
}
