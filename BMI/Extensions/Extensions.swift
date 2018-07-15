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

extension CGFloat {
    /** Degrees to Radian **/
    var degrees: CGFloat {
        return self * (180.0 / .pi)
    }
    
    /** Radians to Degrees **/
    var radians: CGFloat {
        return self / 180.0 * .pi
    }
}

extension CALayer {
    func drawCurvedString(text: NSAttributedString, angle: CGFloat, radius: CGFloat) {
        var radAngle = angle.radians
        
        let textSize = text.boundingRect(
            with: CGSize(width: .max, height: .max),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil)
            .integral
            .size
        
        let perimeter: CGFloat = 2 * .pi * radius
        let textAngle: CGFloat = textSize.width / perimeter * 2 * .pi
        
        var textRotation: CGFloat = 0
        var textDirection: CGFloat = 0
        
        if angle > CGFloat(10).radians, angle < CGFloat(170).radians {
            // bottom string
            textRotation = 0.5 * .pi
            textDirection = -2 * .pi
            radAngle += textAngle / 2
        } else {
            // top string
            textRotation = 1.5 * .pi
            textDirection = 2 * .pi
            radAngle -= textAngle / 2
        }
        
        for c in 0..<text.length {
            let letter = text.attributedSubstring(from: NSRange(c..<c+1))
            let charSize = letter.boundingRect(
                with: CGSize(width: .max, height: .max),
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                context: nil)
                .integral
                .size
            
            let letterAngle = (charSize.width / perimeter) * textDirection
            let x = radius * cos(radAngle + (letterAngle / 2))
            let y = radius * sin(radAngle + (letterAngle / 2))
            
            let singleChar = drawText(
                on: self,
                text: letter,
                frame: CGRect(
                    x: (self.frame.size.width / 2) - (charSize.width / 2) + x,
                    y: (self.frame.size.height / 2) - (charSize.height / 2) + y,
                    width: charSize.width,
                    height: charSize.height))
            self.addSublayer(singleChar)
            singleChar.transform = CATransform3DMakeAffineTransform(CGAffineTransform(rotationAngle: radAngle - textRotation))
            radAngle += letterAngle
        }
    }
    
    
    func drawText(on layer: CALayer, text: NSAttributedString, frame: CGRect) -> CATextLayer {
        let textLayer = CATextLayer()
        textLayer.frame = frame
        textLayer.string = text
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.contentsScale = UIScreen.main.scale
        return textLayer
    }
}

