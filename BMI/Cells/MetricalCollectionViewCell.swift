//
//  MetricalCollectionViewCell.swift
//  BMI
//
//  Created by Piotr Kupczyk on 23.06.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//

import UIKit

class MetricalCollectionViewCell: AbstractCollectionViewCell {
    
    override func setupViews() {
        addSubview(container)
        addSubview(resultLabel)
        
        container.addSubview(valuesContainer)
        
        valuesContainer.addSubview(heightContainer)
        valuesContainer.addSubview(weightContainer)
        valuesContainer.addSubview(countButton)
        
        heightContainer.addSubview(height)
        heightContainer.addSubview(heightLabel)
        
        weightContainer.addSubview(weight)
        weightContainer.addSubview(weightLabel)
        
        let defaulHeight = CGFloat(45)
        let labelWidth = CGFloat(60)
        
        container.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .zero, size: CGSize(width: 0, height: 2*self.frame.height/3))
        
        resultLabel.anchor(top: container.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        valuesContainer.anchor(top: container.topAnchor, leading: container.leadingAnchor, bottom: container.bottomAnchor, trailing: container.trailingAnchor, padding: UIEdgeInsets(top: 60, left: 60, bottom: -60, right: -60))
        
        heightContainer.anchor(top: valuesContainer.topAnchor, leading: valuesContainer.leadingAnchor, bottom: nil, trailing: valuesContainer.trailingAnchor, padding: UIEdgeInsets(top: 4, left: 4, bottom: 0, right: -4), size: CGSize(width: 0, height: defaulHeight))
        
        weightContainer.anchor(top: heightContainer.bottomAnchor, leading: heightContainer.leadingAnchor, bottom: nil, trailing: heightContainer.trailingAnchor, padding: UIEdgeInsets(top: 32, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: defaulHeight))
        
        //set up height container
        heightLabel.anchor(top: heightContainer.topAnchor, leading: heightContainer.leadingAnchor, bottom: heightContainer.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: labelWidth, height: defaulHeight))
        
        height.anchor(top: heightContainer.topAnchor, leading: heightLabel.trailingAnchor, bottom: heightContainer.bottomAnchor, trailing: heightContainer.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 45, bottom: 0, right: -8))
        
        //set up weight container
        
        weightLabel.anchor(top: weightContainer.topAnchor, leading: weightContainer.leadingAnchor, bottom: weightContainer.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: labelWidth, height: 0))
        
        weight.anchor(top: weightContainer.topAnchor, leading: weightLabel.trailingAnchor, bottom: weightContainer.bottomAnchor, trailing: weightContainer.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 45, bottom: 0, right: -8))
        
        countButton.anchor(top: weightContainer.bottomAnchor, leading: weightContainer.leadingAnchor, bottom: valuesContainer.bottomAnchor, trailing: weightContainer.trailingAnchor, padding: UIEdgeInsets(top: 60, left: 30, bottom: -60, right: -30))
    }
    

}
