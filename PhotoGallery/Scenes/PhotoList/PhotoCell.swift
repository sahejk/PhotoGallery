//
//  PhotoCell.swift
//  PhotoGallery
//
//  Created by Sahej Kaur on 24/06/18.
//  Copyright © 2018 Sahej. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
  @IBOutlet weak var imageView: UIImageView!
  override func prepareForReuse() {
    imageView.image = UIImage(named: "photo_placeholder")
    imageView.associatedDownloadTask?.cancel()
  }
}
