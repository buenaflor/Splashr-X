//
//  AddToCollectionViewItem.swift
//  Splashr-X
//
//  Created by Gino on 17.06.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

protocol AddToCollectionViewItem {
  var title: String? { get }
  var coverPhoto: Photo? { get }
}

extension PhotoCollection: AddToCollectionViewItem { }
