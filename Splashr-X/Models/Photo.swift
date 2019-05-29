//
//  Photo.swift
//  Splashr
//
//  Created by Giancarlo Buenaflor on 03.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

struct Photo: Codable {
  let id: String?
  let created: String?
  let updated: String?
  let description: String?
  let color: String?
  var likes: Int?
  var likedByUser: Bool?
  let downloads: Int?
  let views: Int?
  let width: Int?
  let height: Int?
  let user: User?
  let urls: ImageURLs?
  let location: Location?
  let exif: Exif?
  let collectionsItBelongs: [PhotoCollection]?
  let links: Links?
  let categories: [Category]?
  
  enum CodingKeys: String, CodingKey {
    case id
    case created = "created_at"
    case updated = "updated_at"
    case description
    case color
    case likes
    case likedByUser = "liked_by_user"
    case downloads
    case views
    case width
    case height
    case user
    case urls
    case location
    case exif
    case collectionsItBelongs = "current_user_collections"
    case links
    case categories
  }
}

extension Photo: IdentifiableType {
  typealias Identity = String
  
  var identity: Identity {
    guard id != nil else { return "" }
    return id!
  }
}

extension Photo: Equatable {
  static func ==(lhs: Photo, rhs: Photo) -> Bool {
    return lhs.id == rhs.id &&
      lhs.created == rhs.created &&
      lhs.user?.id == rhs.user?.id
  }
}
