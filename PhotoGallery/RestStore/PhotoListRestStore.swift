//
//  PhotoListRestStore.swift
//  PhotoGallery
//
//  Created by Sahej Kaur on 23/06/18.
//  Copyright © 2018 Sahej. All rights reserved.
//

import Foundation

protocol PhotoListStore {
  func searchPhoto(searchText: String, completion: @escaping (_ photos: Photos) -> Void)
  func searchPhoto(searchText: String,pageNo: Int, completion: @escaping (_ photos: Photos) -> Void)
}

class PhotoListRestStore: PhotoListStore {
  let restClient: RestInterface
  init(restClient: RestInterface) {
    self.restClient = restClient
  }
  
  enum APIEndpoint: String {
    case searchPhotos = ""
  }
  
  private let pageSize = 20
  
  func searchPhoto(searchText: String, completion: @escaping (_ photos: Photos) -> Void) {
    self.searchPhoto(searchText: searchText, pageNo: 1, completion: completion)
  }
  
  func searchPhoto(searchText: String,pageNo: Int, completion: @escaping (_ photos: Photos) -> Void) {
    self.restClient.get(path: APIEndpoint.searchPhotos.rawValue, query: getQueryStringForSearch(searchText, page: pageNo), headers: [:]) { (response) in
      
      do {
        let photosDict = response["photos"] as? JSONObject ?? [:]
        let data = try JSONSerialization.data(withJSONObject: photosDict, options: JSONSerialization.WritingOptions.prettyPrinted)
        let photos = try JSONDecoder().decode(Photos.self, from: data)
        completion(photos)
      } catch {
        
      }
    }

  }
  
  private func getQueryStringForSearch(_ text: String, page: Int) -> String {
    return "method=flickr.photos.search&api_key=1c1e672e291eaee204d3a2f234dc8c32&text=\(text)&per_page=\(pageSize)&page=\(page)&format=json&nojsoncallback=1"
  }
}
