//
//  PhotoRepoType.swift
//  Splashr-X
//
//  Created by Gino on 29.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import Foundation

typealias Photos = [Photo]

protocol PhotosRepoType {
  func photos(byPageNumber pageNumber: Int, orderBy: OrderBy, curated: Bool, completion: @escaping  ((Result<Photos, Error>) -> Void))
  
  func likePhoto(id: String, completion: @escaping (NonPublicScopeError?) -> Void)
  
  func unlikePhoto(id: String, completion: @escaping (NonPublicScopeError?) -> Void)
  
  func taskIsWaitingForConnectivity(_ handler: @escaping ((URLSession, URLSessionTask) -> Void))
}
