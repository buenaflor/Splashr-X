//
//  CellConfigurator.swift
//  Splashr-X
//
//  Created by Gino on 28.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

protocol CellConfigurator {
  associatedtype Model
  var model: Model { get set }
  
  func create(from tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
}
