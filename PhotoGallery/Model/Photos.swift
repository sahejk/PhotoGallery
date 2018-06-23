//
//  Photos.swift
//  PhotoGallery
//
//  Created by Sahej Kaur on 23/06/18.
//  Copyright © 2018 Sahej. All rights reserved.
//

import Foundation
struct Photos: Decodable {
  let page: Int
  let pages: Int
  let perpage: Int
  let total: String
  let photo: [Photo]
}
