//
//  PhotoListInteractor.swift
//  PhotoGallery
//
//  Created by Sahej Kaur on 23/06/18.
//  Copyright © 2018 Sahej. All rights reserved.
//

import Foundation

protocol PhotoListInteractorInterface {
  func searchPhotos(request: PhotoListModels.PhotoSearch.Request)
}

final class PhotoListInteractor: PhotoListInteractorInterface {
  var presenter: PhotoListPresenterInterface?
  func searchPhotos(request: PhotoListModels.PhotoSearch.Request) {
    
  }

}
