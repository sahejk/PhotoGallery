//
//  PhotoListModels.swift
//  PhotoGallery
//
//  Created by Sahej Kaur on 23/06/18.
//  Copyright © 2018 Sahej. All rights reserved.
//

struct PhotoListModels {
  struct PhotoSearch {
    struct Request {
      let searchText: String
    }
    
    struct Response {
      let photos: [Photo]
    }    
  }
}
