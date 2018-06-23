//
//  Photo.swift
//  PhotoGallery
//
//  Created by Sahej Kaur on 23/06/18.
//  Copyright © 2018 Sahej. All rights reserved.
//

import Foundation

struct Photo: Decodable {
  let id: String
  let farm: Int
  let secret: String
  let server: String
}
