//
//  IdentifiableType.swift
//  Splashr
//
//  Created by Giancarlo Buenaflor on 03.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

public protocol IdentifiableType {
  associatedtype Identity: Hashable
  
  var identity : Identity { get }
}
