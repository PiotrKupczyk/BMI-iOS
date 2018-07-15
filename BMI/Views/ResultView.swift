
//  ResultView.swift
//  testApp
//
//  Created by Piotr Kupczyk on 08.07.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//

import UIKit

class ResultView: UIView {
    
    private var subLayers = [CAShapeLayer]()
    private var resultAnimator: UIViewPropertyAnimator?
    
    let result: UILabel = {
       let label = UILabel()
        label.backgroundColor = .clear
        label.clipsToBounds = true
        label.layer.borderWidth = 8
        label.layer.borderColor = UIColor.black.cgColor
        label.textAlignment = .center
        label.font = label.font.withSize(24)
        label.clipsToBounds = true
        return label
    }()
    
    //MARK: - show result
    
    public func showResult(bmi: Bmi.BmiResult) {
        
        //choose layer of given bmi index
        let layer = subLayers[bmi.index.hashValue]
        
        //remove previous animation
        for layer in subLayers {
            layer.removeAllAnimations()
        }
        
        //add animations
        addLayerAnimations(layer)
        
        //show result with animation
        drawResultLabel(bmi: bmi)
        print("before \(result.bounds)")
        resultAnimator?.startAnimation()
        print("after \(result.bounds)")
    }
    
    fileprivate func addLayerAnimations(_ layer: CAShapeLayer) {
        let minOpacity = 0.35
        let maxOpacity = 1
        let duration = 2.5
        
        //add animation
        let animations = CAAnimationGroup()
        animations.duration = duration
        animations.repeatCount = 12
        
        let opacityDown = CABasicAnimation(keyPath: "opacity")
        opacityDown.fromValue = maxOpacity
        opacityDown.toValue = minOpacity
        opacityDown.duration = duration/2
        
        let opacityUp = CABasicAnimation(keyPath: "opacity")
        opacityUp.fromValue = minOpacity
        opacityUp.toValue = maxOpacity
        opacityUp.duration = duration/2
        opacityUp.beginTime = duration/2
        
        animations.animations = [opacityDown, opacityUp]
        layer.add(animations, forKey: nil)
        
        resultAnimator = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn) {
            self.result.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
        resultAnimator?.addCompletion { _ in
            UIView.animate(withDuration: 0.25, animations: {
                self.result.transform = self.result.transform.inverted()
            })
        }
    }
    
    private func drawResultLabel(bmi: Bmi.BmiResult) {
        let subCenter = CGPoint(x: bounds.size.width/2, y: bounds.size.height/2)
        let size = min(self.bounds.width/2, self.bounds.height/2)
        let orgin = CGPoint(x: subCenter.x - size, y: subCenter.y - size)
        result.frame = CGRect(origin: orgin, size: CGSize(width: size, height: size))
        result.layer.cornerRadius = size/2
        result.text = "\(bmi.value)"
        result.layer.borderColor = UIColor(gradientStyle: .leftToRight, withFrame: result.bounds, andColors: [bmi.index.color, bmi.index.color.darken(byPercentage: 0.3)!]).cgColor
    }
    
    //MARK: - Draw init
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        removeAllSublayerBeforeDraw()
        drawView()
    }
    
    fileprivate func removeAllSublayerBeforeDraw() {
        for layer in subLayers {
            layer.removeFromSuperlayer()
        }
    }
    
    private func drawView() {
        
        let center = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        let smallerAxis = min(self.bounds.height, self.bounds.width)
        let radius = smallerAxis/2 - 16
        let lineWidth:CGFloat = radius/2
        
        let startAngle = 3*CGFloat.pi/4
        let endAngle = 9*CGFloat.pi/4
        let allAngle = endAngle - startAngle
        let equalSpace:CGFloat = allAngle/CGFloat(BmiIndex.allCases.count)
        
        var startSubAngle = startAngle
        var endSubAngle = startSubAngle + equalSpace
        
        for index in BmiIndex.allCases {
            let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startSubAngle, endAngle: endSubAngle, clockwise: true)
            let subLayer = CAShapeLayer()
            
            //create colorfull part of the circle
            subLayer.path = circularPath.cgPath
            subLayer.lineWidth = lineWidth
            subLayer.fillColor = UIColor.clear.cgColor
            subLayer.strokeColor = index.color.cgColor
            
            //add shadows under
            subLayer.shadowOpacity = 0.5
            subLayer.shadowOffset = CGSize(width: 1.0, height: 2.0)
            
            //add bmi range in current circle part
            
            
            //iterate to next circle
            startSubAngle = endSubAngle
            endSubAngle += equalSpace
            self.layer.addSublayer(subLayer)
            self.subLayers.append(subLayer)
            self.layer.drawCurvedString(text: NSAttributedString(string: index.stringRange, attributes: [NSAttributedStringKey.font: UIFont(name: "HiraMinProN-W3", size: 18)!]), angle: (startSubAngle - (endSubAngle-startSubAngle)/2).degrees, radius: radius-5
            )
        }

    }
    
    //MARK: - init
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.addSubview(result)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
