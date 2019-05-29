//
//  PhotoCollection.swift
//  Splashr
//
//  Created by Giancarlo Buenaflor on 03.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

struct PhotoCollection: Codable {
  let id: Int?
  let coverPhoto: Photo?
  let isCurated: Bool?
  let isFeatured: Bool?
  let title: String?
  let description: String?
  let totalPhotos: Int?
  let isPrivate: Bool?
  let publishedAt: String?
  let updatedAt: String?
  let user: User?
  let links: Links?
  
  enum CodingKeys: String, CodingKey {
    case id
    case coverPhoto = "cover_photo"
    case isCurated = "curated"
    case isFeatured = "featured"
    case title
    case description
    case totalPhotos = "total_photos"
    case isPrivate = "private"
    case publishedAt = "published_at"
    case updatedAt = "updated_at"
    case user
    case links
  }
  
//  func encode(to encoder: Encoder) throws {
//    var container = encoder.container(keyedBy: CodingKeys.self)
//    try container.encode(id, forKey: .id)
//    try container.encode(coverPhoto, forKey: .coverPhoto)
//    try container.encode(isCurated, forKey: .isCurated)
//    try container.encode(isFeatured, forKey: .isFeatured)
//    try container.encode(title, forKey: .title)
//    try container.encode(description, forKey: .description)
//    try container.encode(totalPhotos, forKey: .totalPhotos)
//    try container.encode(isPrivate, forKey: .isPrivate)
//    try container.encode(publishedAt, forKey: .publishedAt)
//    try container.encode(updatedAt, forKey: .updatedAt)
//    try container.encode(user, forKey: .user)
//    try container.encode(links, forKey: .links)
//  }
  
//  init(from decoder: Decoder) throws {
//    let container = try decoder.container(keyedBy: CodingKeys.self)
//    id = try container.decode(Int.self, forKey: .id)
//    coverPhoto = try container.decode(Photo.self, forKey: .coverPhoto)
//    isCurated = try container.decode(Bool.self, forKey: .isCurated)
//    isFeatured = try container.decode(Bool.self, forKey: .isFeatured)
//    title = try container.decode(String.self, forKey: .title)
//    description = try container.decode(String.self, forKey: .description)
//    totalPhotos = try container.decode(Int.self, forKey: .totalPhotos)
//    isPrivate = try container.decode(Bool.self, forKey: .isPrivate)
//    publishedAt = try container.decode(String.self, forKey: .publishedAt)
//    updatedAt = try container.decode(String.self, forKey: .updatedAt)
//    user = try container.decode(User.self, forKey: .user)
//    links = try container.decode(Links.self, forKey: .links)
//  }
}

extension PhotoCollection: IdentifiableType {
  typealias Identity = Int
  
  var identity: Identity {
    guard id != nil else { return -999 }
    return id!
  }
}

struct CollectionResponse: Decodable {
  let photo: Photo?
  let collection: PhotoCollection?
  let user: User?
  let createdAt: String?
  
  enum CodingKeys: String, CodingKey {
    case photo
    case collection
    case user
    case createdAt = "created_at"
  }
}

extension PhotoCollection {
  static let photoCollectionsFilePath = "PhotoCollectionsCached"
  static func store(objects: PhotoCollections) {
    do {
      let data = try NSKeyedArchiver.archivedData(withRootObject: objects, requiringSecureCoding: false)
      let url = getDocumentsDirectory().appendingPathComponent(photoCollectionsFilePath)
      try data.write(to: url)
      print("success writing")
    } catch {
      print("error: ", error)
      
    }
  }
  
  static func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
  // Retrieve an Array of products
//  func retriveAll() -> [Product]? {
//    guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: productsFile.path) as? Data else { return nil }
//    do {
//      let products = try PropertyListDecoder().decode([Product].self, from: data)
//      return products
//    } catch {
//      print("Retrieve Failed")
//      return nil
//    }
//  }
}
