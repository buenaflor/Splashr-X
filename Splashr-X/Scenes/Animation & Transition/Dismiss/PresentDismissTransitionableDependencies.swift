//
//  PresentDismissTransitionableDependencies.swift
//  Splashr-X
//
//  Created by Gino on 05.06.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

protocol PresentDismissTransitionableDependencies {
  var delegate: UIViewControllerTransitioningDelegate? { get }
  var interactor: DismissInteractor { get }
}

extension PhotosViewController: PresentDismissTransitionableDependencies {
  weak var delegate: UIViewControllerTransitioningDelegate? {
    return self
  }
}
