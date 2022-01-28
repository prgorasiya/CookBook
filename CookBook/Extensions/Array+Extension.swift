//
//  Array+Extension.swift
//  CookBook
//
//  Created by paras gorasiya on 28/01/22.
//

import Foundation

let bullet = "• "
extension Array where Element == String {
    var bulletList: String {
        var text = ""
        for (index, item) in enumerated() {
            if index != 0 {
                text += "\n"
            }
            text += bullet + item
        }
        return text
    }
}
