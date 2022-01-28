//
//  DetailsTableViewCell.swift
//  CookBook
//
//  Created by paras gorasiya on 28/01/22.
//

import Foundation
import UIKit

class DetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var storyLabel: UILabel!

    func updateCell(with model: BasicDetailCellModel) {
        titleLabel.text = model.title

        userImageView.layer.cornerRadius = userImageView.frame.size.height / 2
        if let url = model.user.imageUrl {
            userImageView.setImageWith(urlString: url, placeholderImage: nil)
        }

        userNameLabel.text = model.user.name
        storyLabel.text = model.story

        layoutIfNeeded()
    }
}
