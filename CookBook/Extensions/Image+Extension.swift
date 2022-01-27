//
//  Image+Extension.swift
//  CookBook
//
//  Created by paras gorasiya on 27/01/22.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func setImageWith(urlString : String, placeholderImage: UIImage?, showActivityIndicator: Bool = false) {
        let url = URL(string: urlString)
        if url == nil { return }
        self.image = nil

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }

        if placeholderImage != nil {
            self.image = placeholderImage
        }

        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .medium)
        if showActivityIndicator {
            addSubview(activityIndicator)
            activityIndicator.startAnimating()
            activityIndicator.center = self.center
        }

        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                    if showActivityIndicator {
                        activityIndicator.removeFromSuperview()
                    }
                }
            }
        }).resume()
    }
}
