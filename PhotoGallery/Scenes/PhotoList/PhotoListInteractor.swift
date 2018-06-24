//
//  PhotoListInteractor.swift
//  PhotoGallery
//
//  Created by Sahej Kaur on 23/06/18.
//  Copyright © 2018 Sahej. All rights reserved.
//

import Foundation

protocol PhotoListInteractorInterface {
  var selectedIndex: Int {get set}
  func getSelectedPhoto() -> Photo
  func searchPhotos(request: PhotoListModels.PhotoSearch.Request)
  var restStore: PhotoListStore? {get set}
  func hasNextSlice() -> Bool
  func fetchNextSlice()
}

final class PhotoListInteractor: PhotoListInteractorInterface {
  var presenter: PhotoListPresenterInterface?
  var restStore: PhotoListStore?
  var currentPage: Int = 0
  var totalPages: Int = 0
  var searchText: String = ""
  var selectedIndex: Int = 0
  var photos: [Photo] = [] {
    didSet {
      presentPhotos()
    }
  }
  func searchPhotos(request: PhotoListModels.PhotoSearch.Request) {
    searchText = request.searchText
    currentPage = 0
    photos = []
    totalPages = 0
    fetchNextSlice()
  }
  
  func presentPhotos() {
    presenter?.presentPhotoData(response: PhotoListModels.PhotoSearch.Response(photos: photos))
  }
  
  func hasNextSlice() -> Bool {
    return currentPage < totalPages
  }
  
  func getSelectedPhoto() -> Photo {
    return photos[selectedIndex]
  }
  
  func fetchNextSlice() {
    restStore?.searchPhoto(searchText: searchText, pageNo: currentPage + 1, completion: {[weak self] photos in
      self?.photos = (self?.photos ?? []) + photos.photo
      self?.currentPage = photos.page
      self?.totalPages = photos.pages
     })

  }
  
}
