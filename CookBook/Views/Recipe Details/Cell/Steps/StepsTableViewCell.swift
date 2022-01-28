//
//  StepsTableViewCell.swift
//  CookBook
//
//  Created by paras gorasiya on 28/01/22.
//

import Foundation
import UIKit

class StepsTableViewCell: UITableViewCell {
    @IBOutlet weak var stepsLabel: UILabel!

    func updateCell(with model: StepsCellModel) {
        stepsLabel.attributedText = model.steps.bulletList(with: stepsLabel.font, textColor: stepsLabel.textColor)
        layoutIfNeeded()
    }
}
