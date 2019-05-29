//
//  Photo+TableViewItem.swift
//  Splashr-X
//
//  Created by Gino on 29.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

protocol PhotoTableViewItem {
  var created: String? { get }
  var updated: String? { get }
  var description: String? { get }
  var likes: Int? { get }
  var likedByUser: Bool? { get }
  var downloads: Int? { get }
  var views: Int? { get }
  var width: Int? { get }
  var height: Int? { get }
  var user: User? { get }
  var urls: ImageURLs? { get }
  var color: String? { get }
}

extension Photo: PhotoTableViewItem {
  
}

