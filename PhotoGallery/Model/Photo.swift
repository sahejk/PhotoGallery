//
//  Photo.swift
//  PhotoGallery
//
//  Created by Sahej Kaur on 23/06/18.
//  Copyright © 2018 Sahej. All rights reserved.
//

import Foundation

enum PhotoSize: String {
  case thumbnail = "_t.jpg"
  case highRes = ".jpg"
}

struct Photo: Decodable {
  let id: String
  let farm: Int
  let secret: String
  let server: String
}

extension Photo {
  func getPhotUrl(size: PhotoSize = .thumbnail) -> URL? {
    let urlString = "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)\(size.rawValue)"
    return URL(string: urlString)

  }
}
