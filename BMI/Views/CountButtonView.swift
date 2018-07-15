//
//  CountButtonView.swift
//  BMI
//
//  Created by Piotr Kupczyk on 10.07.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//

import UIKit

class CountButtonView: UIView {
    var shapeLayer: CAShapeLayer?
    
    let countButton: UIButton = {
        let button = UIButton()
        button.setTitle("Calculate your bmi", for: UIControlState.normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textColor = .black
//        button.clipsToBounds = true
        button.layer.shadowOpacity = 0.5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.masksToBounds = false
        return button
    }()
    
    fileprivate func styleCountButton() {
        self.countButton.backgroundColor = UIColor(gradientStyle: .diagonal, withFrame: self.countButton.bounds, andColors: [UIColor.flatGreen.lighten(byPercentage: 0.2)!, UIColor.flatGreen.darken(byPercentage: 0.2)!])
        shapeLayer = CAShapeLayer()
        shapeLayer?.path = UIBezierPath(roundedRect: countButton.bounds, cornerRadius: self.bounds.size.height/2).cgPath
        self.countButton.layer.mask = shapeLayer
    }
    
    override func draw(_: CGRect) {
        //shape layer is nil before first draw
        guard self.shapeLayer != nil else {
            self.shapeLayer?.removeFromSuperlayer()
            styleCountButton()
            return
        }
        styleCountButton()
    }
    
    fileprivate lazy var darkShadowLayer:CAShapeLayer = {
        let layer = CAShapeLayer()
        let path = UIBezierPath(rect: countButton.bounds)
        layer.path = path.cgPath
        
        layer.cornerRadius = countButton.layer.cornerRadius
        layer.fillColor = UIColor.flatBlack.withAlphaComponent(0.2).cgColor
        layer.backgroundColor = UIColor.clear.cgColor
        return layer
    }()
    
    @objc func buttonDown() {
        countButton.layer.addSublayer(darkShadowLayer)
        UIView.animate(withDuration: 0.12, animations: {
            self.countButton.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        })
    }
    
    func buttonUp() {
        let _ = countButton.layer.sublayers?.popLast()
        UIView.animate(withDuration: 0.12) {
            self.countButton.transform = self.countButton.transform.inverted()
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
        self.backgroundColor = .clear
        countButton.addTarget(self, action: #selector(buttonDown), for: .touchDown)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setupView() {
        self.addSubview(self.countButton)
        self.countButton.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 8, bottom: -8, right: -8))
    }
}
