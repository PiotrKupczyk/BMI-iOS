//
//  ResultView.swift
//  testApp
//
//  Created by Piotr Kupczyk on 08.07.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//

import UIKit

class ResultView: UIView {
    
    private var subLayers = [CAShapeLayer]()
    private let colors = [UIColor.BMI.underweight, UIColor.BMI.norm, UIColor.BMI.overweight, UIColor.BMI.obese]
    
    public func showResult() {
        let layerToAnimate = self.subLayers[1]
        let colorAnimation = CABasicAnimation(keyPath: "strokeColor")
        colorAnimation.duration = 1.25
        colorAnimation.fromValue = layerToAnimate.strokeColor
        colorAnimation.toValue = UIColor.flatGreen.darken(byPercentage: 0.5)
        colorAnimation.autoreverses = true
        colorAnimation.repeatCount = 10
        colorAnimation.fillMode = kCAFillModeBoth
        
        let lineWidthAnimation = CABasicAnimation(keyPath: "lineWidth")
        lineWidthAnimation.duration = 1.25
        lineWidthAnimation.fromValue = layerToAnimate.lineWidth
        lineWidthAnimation.toValue = layerToAnimate.lineWidth + 10
        lineWidthAnimation.autoreverses = true
        lineWidthAnimation.repeatCount = 10
        lineWidthAnimation.fillMode = kCAFillModeBoth
        
        layerToAnimate.add(colorAnimation, forKey: "strokeColor")
        layerToAnimate.add(lineWidthAnimation, forKey: "lineWidth")
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawView()
    }
    
    private func drawView() {
        let center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        let bigerAxis = min(self.bounds.height, self.bounds.width)
        let radius = bigerAxis/2 - 32.0
        let lineWidth:CGFloat = radius/2
        
        
        let startAngle = 3*CGFloat.pi/4
        let endAngle = 9*CGFloat.pi/4
        let allAngle = endAngle - startAngle
        let equalSpace:CGFloat = allAngle/CGFloat(colors.count)
        
        var startSubAngle = startAngle
        var endSubAngle = startSubAngle + equalSpace
        
        for color in colors {
            let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startSubAngle, endAngle: endSubAngle, clockwise: true)
            let subLayer = CAShapeLayer()
            
            //create colorfull part of the circle
            subLayer.path = circularPath.cgPath
            subLayer.lineWidth = lineWidth
            subLayer.fillColor = UIColor.clear.cgColor
            subLayer.strokeColor = color.cgColor
            
            //add shadows under
            subLayer.shadowOpacity = 0.5
            subLayer.shadowOffset = CGSize(width: 1.0, height: 2.0)
            
            //iterate to next circle
            startSubAngle = endSubAngle
            endSubAngle += equalSpace
            self.layer.addSublayer(subLayer)
            self.subLayers.append(subLayer)
        }
    }
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .clear
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
