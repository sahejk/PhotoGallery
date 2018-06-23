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
  func hasNextSlice() -> Bool
  func fetchNextSlice()
}

final class PhotoListInteractor: PhotoListInteractorInterface {
  var presenter: PhotoListPresenterInterface?
  var restStore: PhotoListStore?
  var currentPage: Int = 0
  var totalPages: Int?
  var searchText: String = ""
  var photos: [Photo] = [] {
    didSet {
      presentPhotos()
    }
  }
  func searchPhotos(request: PhotoListModels.PhotoSearch.Request) {
    searchText = request.searchText
    fetchNextSlice()
  }
  
  func presentPhotos() {
    presenter?.presentPhotoData(response: PhotoListModels.PhotoSearch.Response(photos: photos))
  }
  
  func hasNextSlice() -> Bool {
    guard let totalPages = totalPages else {return false}
    return currentPage < totalPages
  }
  
  func fetchNextSlice() {
    restStore?.searchPhoto(searchText: searchText, pageNo: currentPage + 1, completion: {[weak self] photos in
      self?.photos = (self?.photos ?? []) + photos.photo
      self?.currentPage = photos.page
      self?.totalPages = photos.pages
      print(photos)
    })

  }
  
}
