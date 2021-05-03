//
//  GradientView.swift
//  Weather
//
//  Created by Pratap SIngh on 14/04/21.
//

import UIKit
@IBDesignable
class GradientView: View {
    let gradientLayer = CAGradientLayer()
    @IBInspectable
    var colorBottom: UIColor = UIColor.red
    @IBInspectable
    var colorTop: UIColor = UIColor.blue
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override func layoutSubviews() {
            gradientLayer.frame = self.bounds
        }
    
    override func draw(_ rect: CGRect) {
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.8, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
