//
//  RecipeTableViewCell.swift
//  CookBook
//
//  Created by paras gorasiya on 27/01/22.
//

import Foundation
import UIKit

class RecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!

    var model: Recipe!

    func updateCell(with model: Recipe) {
        self.model = model

        containerView.layer.cornerRadius = 10

        if let imageURL = model.imageUrl {
            recipeImageView.setImageWith(urlString: imageURL, placeholderImage: nil, showActivityIndicator: true)
        }

        titleLabel.text = model.title

        if let imageURL = model.imageUrl {
            userImageView.setImageWith(urlString: imageURL, placeholderImage: nil, showActivityIndicator: true)
        }
        userNameLabel.text = model.user.name
        layoutIfNeeded()
    }
}
