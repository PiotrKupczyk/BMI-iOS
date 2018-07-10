//
//  Extensions.swift
//  BMI
//
//  Created by Piotr Kupczyk on 23.06.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//

import UIKit
import ChameleonFramework

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }

    func setGradientBackground(colors: [CGColor]) {
        //It's safer if it's loaded async because in this way we're sure that gradient is loaded after viewDidLoad()
        DispatchQueue.main.async {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.bounds
            gradientLayer.colors = colors
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    func addDarkBackground() {
        let layer = CAShapeLayer()
        let size = CGSize(width: self.bounds.size.width+32, height: self.bounds.height+32)
        let rect = CGRect(origin: CGPoint(x: -16, y: -16), size: size)
        let path = UIBezierPath(rect: rect)
        layer.path = path.cgPath
        layer.opacity = 0.2
        layer.fillColor = UIColor.black.cgColor
        self.layer.addSublayer(layer)
    }
    
    func removeDarkBackground() {
        _ = self.layer.sublayers?.popLast()
    }
}

extension UIColor {
    struct AppColors {
        static let primaryColor = UIColor.flatGreen
        static let darkPrimaryColor = UIColor.flatGreenDark
        static let backgroundColor = UIColor.white
    }

    struct BMI {
        static let underweight = UIColor.flatSand
        static let norm = UIColor.flatGreen
        static let overweight = UIColor.flatYellow
        static let obese = UIColor.flatRed
    }
}

extension Double {
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension UITextField {
    func addUnderline() {
        self.borderStyle = .none
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        self.layer.shadowColor = UIColor.flatGray.cgColor
        self.layer.masksToBounds = false
        //trick that make view transparent and shadows is stil shown
        self.backgroundColor = UIColor.white.withAlphaComponent(1.0)
    }
}
