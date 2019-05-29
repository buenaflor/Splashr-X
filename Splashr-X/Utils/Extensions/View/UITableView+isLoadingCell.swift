//
//  UITableView+isLoadingCell.swift
//  Splashr-X
//
//  Created by Gino on 29.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

extension UITableView {
  func isLoadingCell(for indexPath: IndexPath, modelCount: Int) -> Bool {
    return indexPath.row == modelCount
  }
}


