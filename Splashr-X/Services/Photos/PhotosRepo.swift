//
//  PhotoRepo.swift
//  Splashr-X
//
//  Created by Gino on 29.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

class PhotosRepo: PhotosRepoType {
  
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
  
  func likePhoto(id: String, completion: @escaping (NonPublicScopeError?) -> Void) {
    // We are checking the accessToken before too but we check again just to be sure
    guard UserSession.accessToken != nil else {
      completion(.noAccessToken)
      return
    }
    unsplash.request(.likePhoto(id: id)) { (response) in
      switch response {
      case .success:
        completion(nil)
        
      // Networking error
      case let .error(error):
        completion(.error(withMessage: error.localizedDescription))
      }

    }
  }
  
  func unlikePhoto(id: String, completion: @escaping (NonPublicScopeError?) -> Void) {
    // We are checking the accessToken before too but we check again just to be sure
    guard UserSession.accessToken != nil else {
      completion(.noAccessToken)
      return
    }
    unsplash.request(.unlikePhoto(id: id)) { (response) in
      switch response {
      case .success:
        completion(nil)
        
      // Networking error
      case let .error(error):
        completion(.error(withMessage: error.localizedDescription))
      }
      
    }
  }
  
}
