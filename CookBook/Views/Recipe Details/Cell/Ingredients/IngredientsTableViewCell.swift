//
//  IngredientsTableViewCell.swift
//  CookBook
//
//  Created by paras gorasiya on 28/01/22.
//

import Foundation
import UIKit

class IngredientsTableViewCell: UITableViewCell {
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    func updateCell(with model: IngredientsCellModel) {
        ingredientsLabel.attributedText = model.ingredients.bulletList(with: ingredientsLabel.font, textColor: ingredientsLabel.textColor)
        layoutIfNeeded()
    }
}
