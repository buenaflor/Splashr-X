//
//  CollectionsRepoType.swift
//  Splashr-X
//
//  Created by Gino on 29.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

typealias PhotoCollections = [PhotoCollection]

protocol CollectionsRepoType {
  func collections(byPageNumber page: Int, curated: Bool, completion: @escaping  ((Result<PhotoCollections, Error>) -> Void))
  
  func collections(withUsername username: String, completion: @escaping ((Result<PhotoCollections, Error>) -> Void))
  
  func addPhotoToCollection(withId id: Int, photoId: String, completion: @escaping ((Result<Photo, Error>) -> Void))
  
  var isWaitingForConnectivityHandler: ((URLSession, URLSessionTask) -> Void)? { get set }
}
