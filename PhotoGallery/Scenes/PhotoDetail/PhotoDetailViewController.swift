//
//  PhotoDetailViewController.swift
//  PhotoGallery
//
//  Created by Sahej Kaur on 24/06/18.
//  Copyright © 2018 Sahej. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
  var imageThumbnail: UIImage?
  var photo: Photo?
  @IBOutlet weak var imageView: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()
    imageView.image = imageThumbnail
    guard let photoUrl = photo?.getPhotUrl(size: .highRes) else {
      return
    }
    ImageDownloadManager.shared.downloadImage(requestURL: photoUrl) { (image, url) in
      self.imageView.image = image
    }
  }
  
}
