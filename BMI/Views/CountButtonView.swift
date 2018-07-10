//
//  CountButtonView.swift
//  BMI
//
//  Created by Piotr Kupczyk on 10.07.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//

import UIKit

class CountButtonView: UIView {
    
    let countButton: UIButton = {
        let button = UIButton()
        button.setTitle("Count", for: UIControlState.normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textColor = .black
//        button.sizeToFit()
        button.clipsToBounds = true
        button.backgroundColor = .white
        return button
    }()
    
    override func draw(_: CGRect) {
//        setupView()
        addGradientBorder()
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
        addGradientBorder()
        makeButtonCircular()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func makeButtonCircular() {
        countButton.layer.cornerRadius = self.bounds.width/2
    }

    private func addGradientBorder() {
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.countButton.frame.size)
        gradient.colors = [UIColor.BMI.underweight, UIColor.BMI.norm, UIColor.BMI.overweight, UIColor.BMI.obese]
        
        let shape = CAShapeLayer()
        shape.lineWidth = 2
        shape.path = UIBezierPath(rect: self.countButton.bounds).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        countButton.layer.addSublayer(shape)
    }
    
    private func setupView() {
        self.addSubview(countButton)
        let diameter = min(self.bounds.size.height, self.bounds.size.width)
        let helper = (max(self.bounds.size.height, self.bounds.size.width) - diameter)/2
        
        countButton.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: helper, bottom: 0, right: -helper))
    }
}
