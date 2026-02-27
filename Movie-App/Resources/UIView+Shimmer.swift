//
//  UIView+Shimmer.swift
//  Movie-App
//
//  Created by Deotwal, Jalaj | Ronnie
//

import UIKit

extension UIView {
    func startShimmer() {
        let light = UIColor.white.withAlphaComponent(0.1).cgColor
        let dark = UIColor.black.withAlphaComponent(0.8).cgColor

        let gradient = CAGradientLayer()
        gradient.colors = [dark, light, dark]
        gradient.frame = CGRect(x: -bounds.size.width, y: 0, width: 3 * bounds.size.width, height: bounds.size.height)
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.locations = [0.0, 0.5, 1.0]
        layer.mask = gradient

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.0, 0.25]
        animation.toValue = [0.75, 1.0, 1.0]
        animation.duration = 1.5
        animation.repeatCount = .infinity
        gradient.add(animation, forKey: "shimmer")
    }

    func stopShimmer() {
        layer.mask = nil
    }
}
