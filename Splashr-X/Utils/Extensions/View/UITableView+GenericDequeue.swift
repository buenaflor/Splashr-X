//
//  UITableView+GenericDequeue.swift
//  Splashr-X
//
//  Created by Gino on 27.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

extension UITableView {
  
  func registerNib<T: UITableViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
    let nib = UINib(nibName: String(describing: T.self), bundle: nil)
    self.register(nib, forCellReuseIdentifier: String(describing: T.self))
  }
  
  func register<T: UITableViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
    self.register(T.self, forCellReuseIdentifier: reuseIdentifier ?? String(describing: T.self))
  }
  
  func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
    guard
      let cell = dequeueReusableCell(withIdentifier: String(describing: T.self),
                                     for: indexPath) as? T
      else { fatalError("Could not deque cell with type \(T.self)") }
    
    return cell
  }
  
  func dequeueCell(reuseIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
    return dequeueReusableCell(
      withIdentifier: identifier,
      for: indexPath
    )
  }

}

