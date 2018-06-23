//
//  UICollectionViewDequeExtension.swift
//  PhotoGallery
//
//  Created by Sahej Kaur on 24/06/18.
//  Copyright © 2018 Sahej. All rights reserved.
//

import UIKit
public extension UICollectionView {

public func dequeueReusableCustomCellWithIdentifier<T: UICollectionViewCell>(_ cellIdentifier: String, forIndexPath indexPath: IndexPath) -> T {
  guard let cell = dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? T  else {
    fatalError("Error: error with cellIdentifier \(cellIdentifier) for indexPath \(indexPath) is not \(T.self)")
  }
  return cell
}
}
