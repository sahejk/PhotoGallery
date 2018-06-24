//
//  ImageDownloadManager.swift
//  PhotoGallery
//
//  Created by Sahej Kaur on 24/06/18.
//  Copyright © 2018 Sahej. All rights reserved.
//

import Foundation
import UIKit

class ImageDownloadManager {
  static let shared = ImageDownloadManager()
  
  let urlSession = URLSession.shared
  
  let cache = NSCache<NSString, UIImage>()
  
  private init () {}
  
  @discardableResult func downloadImage(requestURL: URL, completion: @escaping (_ image: UIImage, _ url: URL) -> Void) -> URLSessionDataTask? {
    if let cachedImage = cache.object(forKey: requestURL.absoluteString as NSString) {
      DispatchQueue.main.async {
        completion(cachedImage, requestURL)
      }
      return nil
    } else {
      let downloadTask = urlSession.dataTask(with: requestURL, completionHandler: { (data, urlResponse, error) in
        if let imageData = data, let image = UIImage(data: imageData) {
          DispatchQueue.main.async {
            self.cache.setObject(image, forKey: requestURL.absoluteString as NSString)
            completion(image, requestURL)
          }
        }
      })
      downloadTask.resume()
      return downloadTask
    }
  }
}

