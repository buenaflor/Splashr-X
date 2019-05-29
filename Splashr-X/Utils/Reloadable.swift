//
//  Reloadable.swift
//  Splashr-X
//
//  Created by Gino on 28.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

protocol Reloadable {
  associatedtype T
  func reloadAll(_ models: [T])
  func append(_ model: T)
}
