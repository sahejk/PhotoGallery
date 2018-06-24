//
//  PhotoListConfigurator.swift
//  PhotoGallery
//
//  Created by Sahej Kaur on 23/06/18.
//  Copyright © 2018 Sahej. All rights reserved.
//

import Foundation

final class PhotoListConfigurator {
  
  // MARK: - Object lifecycle
  
  static let sharedInstance = PhotoListConfigurator()
  
  private init() {}
  
  // MARK: - Configuration
  
  func configure(viewController: PhotoListViewController) {
    let presenter = PhotoListPresenter()
    presenter.viewController = viewController
    
    let interactor = PhotoListInteractor()
    interactor.presenter = presenter
    interactor.restStore = PhotoListRestStore(restClient: Rest())

    let router = PhotoListRouter()
    router.viewController = viewController
    viewController.router = router
    
    viewController.interactor = interactor
}
  
}
