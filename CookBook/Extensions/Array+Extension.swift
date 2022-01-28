//
//  Array+Extension.swift
//  CookBook
//
//  Created by paras gorasiya on 28/01/22.
//

import Foundation
import UIKit

extension Array where Element == String {
    func bulletList(with font: UIFont, textColor: UIColor) -> NSAttributedString {
        let bullet = "•  "
        let ingredients = self.map { return bullet + $0 }

        var attributes = [NSAttributedString.Key: Any]()
        attributes[.font] = font
        attributes[.foregroundColor] = textColor

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = (bullet as NSString).size(withAttributes: attributes).width
        attributes[.paragraphStyle] = paragraphStyle

        let string = ingredients.joined(separator: "\n\n")
        return NSAttributedString(string: string, attributes: attributes)
    }
}
