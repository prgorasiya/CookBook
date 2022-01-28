//
//  RecipeImageTableViewCell.swift
//  CookBook
//
//  Created by paras gorasiya on 28/01/22.
//

import Foundation
import UIKit

class RecipeImageTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!

    func updateCell(with model: RecipeImageCellModel) {
        if let url = model.urlString {
            recipeImageView.setImageWith(urlString: url, placeholderImage: nil)
        }

        let deviceHeight = UIScreen.main.bounds.height
        imageViewHeightConstraint.constant = deviceHeight / 2
        layoutIfNeeded()
    }
}
