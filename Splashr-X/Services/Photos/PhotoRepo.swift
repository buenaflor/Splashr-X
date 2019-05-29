//
//  PhotoRepo.swift
//  Splashr-X
//
//  Created by Gino on 29.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

class PhotoRepo: PhotoRepoType {
  
  var isWaitingForConnectivityHandler: ((URLSession, URLSessionTask) -> Void)?
  
  private let unsplash: HTTPNetworking<Unsplash>
  
  init(unsplash: HTTPNetworking<Unsplash> = HTTPNetworking<Unsplash>()) {
    self.unsplash = unsplash
    self.unsplash.isWaitingForConnectivityHandler = { [weak self] (urlSession, task) in
      guard let strongSelf = self else {
        return
      }
      strongSelf.isWaitingForConnectivityHandler?(urlSession, task)
    }
  }
  
  func photos(byPageNumber pageNumber: Int, orderBy: OrderBy, curated: Bool, completion: @escaping ((Result<Photos, Error>) -> Void)) {
    let photosPerPage = 20
    
    unsplash.request(.photos(page: pageNumber, perPage: photosPerPage, orderBy: orderBy)) { (response) in
      switch response {
      case let .success(value):
        do {
          let photos = try value.map(to: Photos.self)
          completion(Result.success(photos))
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
