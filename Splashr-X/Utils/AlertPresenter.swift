//
//  AlertPresenter.swift
//  Splashr-X
//
//  Created by Gino on 31.05.19.
//  Copyright © 2019 Giancarlo Buenaflor. All rights reserved.
//

import UIKit

/// Lightweight Presenter that reduces boilerplate code
struct AlertPresenter {
  
  let alertController: UIAlertController
  
  init(title: String, message: String? = nil, preferredStyle: UIAlertController.Style) {
   self.alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
  }
  
  func present(in vc: UIViewController) {
    vc.present(alertController, animated: true)
  }
  
  @discardableResult
  func addAction(title: String, style: UIAlertAction.Style, completionHandler: @escaping (() -> Void)) -> AlertPresenter {
    alertController.addAction(UIAlertAction(title: title, style: style, handler: { (_) in
      completionHandler()
    }))
    return self
  }
}

// MARK: - Custom Presenters

extension AlertPresenter {
  
  /// Custom alert that is presented when saving a photo
  static func savePhotoToLibray(saveHandler: @escaping ((Bool) -> Void)) -> AlertPresenter {
    let alert = AlertPresenter(title: "Save Picture", message: "The picture will be saved in your photos library", preferredStyle: .actionSheet)
    alert.addAction(title: "Save", style: .default) {
      saveHandler(true)
    }
    alert.addAction(title: "Cancel", style: .cancel) {
      saveHandler(false)
    }
    return alert
  }
}
