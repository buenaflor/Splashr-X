//
//  PhotoCollection+TableViewitem.swift
//  Splashr-X
//
//  Created by Gino on 28.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

protocol PhotoCollectionTableViewItem {
  var title: String? { get }
  var description: String? { get }
  var coverPhoto: Photo? { get }
}

extension PhotoCollection: PhotoCollectionTableViewItem {
  
}
