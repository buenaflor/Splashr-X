//
//  CollectionsRepo.swift
//  Splashr-X
//
//  Created by Gino on 27.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

class CollectionsRepo: CollectionsRepoType {
  
  var isWaitingForConnectivityHandler: ((URLSession, URLSessionTask) -> Void)?
  
  private let unsplash: HTTPNetworking<Unsplash>
  
  init(unsplash: HTTPNetworking<Unsplash> = HTTPNetworking<Unsplash>()) {
    self.unsplash = unsplash
    self.unsplash.isWaitingForConnectivityHandler = { [weak self] (urlSession, task) in
      self?.isWaitingForConnectivityHandler?(urlSession, task)
    }
  }
  
  func collections(byPageNumber page: Int, curated: Bool, completion: @escaping ((Result<PhotoCollections, Error>) -> Void)) {
    let photosPerPage = 20
    
    requestCollections(byPageNumber: page, photosPerPage: photosPerPage, completion: completion)
  }
  
  func collections(withUsername username: String, completion: @escaping ((Result<PhotoCollections, Error>) -> Void)) {
    let photosPerPage = 20

    requestCollections(withUsername: username, page: 1, photosPerPage: photosPerPage, completion: completion)
  }
}

fileprivate extension CollectionsRepo {
  
  func requestCollections(withUsername username: String, page: Int, photosPerPage: Int, completion: @escaping ((Result<PhotoCollections, Error>) -> Void)) {
    unsplash.request(.userCollections(username: username, page: page, perPage: photosPerPage)) { (response) in
      switch response {
      case let .success(value):
        do {
          let photoCollections = try value.map(to: PhotoCollections.self)
          completion(Result.success(photoCollections))
        }
        catch {
          // Decoding error
          completion(Result.failure(error))
        }
      // Networking error
      case let .error(error):
        completion(Result.failure(error))
      }
    }
  }
  
  func requestCollections(byPageNumber page: Int, photosPerPage: Int, completion: @escaping ((Result<PhotoCollections, Error>) -> Void)) {
    unsplash.request(.collections(page: page, photosPerPage: photosPerPage)) { (response) in
      switch response {
      case let .success(value):
        do {
          let photoCollections = try value.map(to: PhotoCollections.self)
          completion(Result.success(photoCollections))
        }
        catch {
          // Decoding error
          completion(Result.failure(error))
        }
      // Networking error
      case let .error(error):
        completion(Result.failure(error))
      }
    }
  }
}
