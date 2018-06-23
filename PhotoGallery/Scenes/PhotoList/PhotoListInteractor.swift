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
  var restStore: PhotoListStore? {get set}
}

final class PhotoListInteractor: PhotoListInteractorInterface {
  var presenter: PhotoListPresenterInterface?
  var restStore: PhotoListStore?
  var photos: Photos? {
    didSet {
      presentPhotos()
    }
  }
  func searchPhotos(request: PhotoListModels.PhotoSearch.Request) {
    restStore?.searchPhoto(searchText: request.searchText, completion: {[weak self] photos in
      self?.photos = photos
      print(photos)
    })
  }
  
  func presentPhotos() {
    guard let photos = self.photos else  { return }
    presenter?.presentPhotoData(response: PhotoListModels.PhotoSearch.Response(photos: photos))
  }

}
