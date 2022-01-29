//
//  View+Extension.swift
//  CookBook
//
//  Created by paras gorasiya on 28/01/22.
//

import Foundation
import UIKit

extension UIView {
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, shadowRadius: CGFloat = 1, cornerRadius: CGFloat) {
        let shadowLayer = CAShapeLayer()
        shadowLayer.name = "shadowWithRadius"
        removePreviouslyAddedLayer(name: shadowLayer.name ?? "")
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = offSet
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        shadowLayer.rasterizationScale = UIScreen.main.scale
        layer.insertSublayer(shadowLayer, at: 0)
        shadowLayer.setNeedsDisplay()
        shadowLayer.setNeedsLayout()
    }
    
    func removePreviouslyAddedLayer(name : String) {
        if self.layer.sublayers?.count ?? 0 > 0 {
            self.layer.sublayers?.forEach {
                if $0.name == name {
                    $0.removeFromSuperlayer()
                }
            }
        }
    }
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        let rect = self.bounds
        mask.frame = rect
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
