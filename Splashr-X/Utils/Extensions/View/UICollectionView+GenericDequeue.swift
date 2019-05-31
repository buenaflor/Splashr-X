//
//  UICollectionView+GenericDequeue.swift
//  Splashr-X
//
//  Created by Gino on 31.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

extension UICollectionView {
  
  func registerNib<T: UICollectionViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
    let nib = UINib(nibName: String(describing: T.self), bundle: nil)
    self.register(nib, forCellWithReuseIdentifier: String(describing: T.self))
  }
  
  func register<T: UICollectionViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
    self.register(T.self, forCellWithReuseIdentifier: reuseIdentifier ?? String(describing: T.self))
  }
  
  func dequeue<T: UICollectionViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
    guard
      let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self),
                                     for: indexPath) as? T
      else { fatalError("Could not deque cell with type \(T.self)") }
    
    return cell
  }
  
  func dequeueCell(reuseIdentifier identifier: String, for indexPath: IndexPath) -> UICollectionViewCell {
    return dequeueReusableCell(
      withReuseIdentifier: identifier,
      for: indexPath
    )
  }
  
}
