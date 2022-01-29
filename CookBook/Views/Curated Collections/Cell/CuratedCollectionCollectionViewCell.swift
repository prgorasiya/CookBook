//
//  CuratedCollectionCollectionViewCell.swift
//  CookBook
//
//  Created by paras gorasiya on 26/01/22.
//

import Foundation
import UIKit

class CuratedCollectionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recipeCountLabel: UILabel!
    
    func updateCell(with model: CuratedCollection) {
        //previewImageUrls is not supposed to be empty as per API docs, but one object has empty previewImageUrls, therefore this check
        if let imageURL = model.previewImageUrls.first {
            imageView.setImageWith(urlString: imageURL, placeholderImage: nil, showActivityIndicator: true)
        }
        containerView.layer.cornerRadius = 10
        titleLabel.text = model.title
        titleLabel.layer.cornerRadius = 4
        recipeCountLabel.text = "\(model.recipeCount)"
        recipeCountLabel.layer.cornerRadius = recipeCountLabel.frame.size.height/2
        layoutIfNeeded()
    }
}
