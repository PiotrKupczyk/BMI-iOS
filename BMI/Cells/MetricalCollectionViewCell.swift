//
//  MetricalCollectionViewCell.swift
//  BMI
//
//  Created by Piotr Kupczyk on 23.06.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//

import UIKit

class MetricalCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let heightLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        label.textAlignment = .center

        return label
    }()
    
    let weightLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        return label
    }()
    
    let heightUnitLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        label.textAlignment = .center

        return label
    }()
    
    let weightUnitLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        return label
    }()
    
    let countButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Counter BMI"
        button.backgroundColor = .blue
        return button
    }()
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        return view
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.text = "BMI here"
        label.textAlignment = .center
        return label
    }()
    
    
    private func setupViews() {
        addSubview(container)
        addSubview(resultLabel)
        
        container.addSubview(heightLabel)
        container.addSubview(heightUnitLabel)
        container.addSubview(weightLabel)
        container.addSubview(weightUnitLabel)
        container.addSubview(countButton)
        
        let defaulHeight = CGFloat(80)
        
        container.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .zero, size: CGSize(width: 0, height: 2*self.frame.height/3))
        
        resultLabel.anchor(top: container.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        heightLabel.anchor(top: container.topAnchor, leading: container.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 30, left: 30, bottom: 0, right: 0), size: CGSize(width: defaulHeight*2, height: defaulHeight))

        heightUnitLabel.anchor(top: heightLabel.topAnchor, leading: heightLabel.trailingAnchor, bottom: heightLabel.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0), size: CGSize(width: defaulHeight, height: 0))
        
        weightLabel.anchor(top: heightLabel.bottomAnchor, leading: heightLabel.leadingAnchor, bottom: nil, trailing: heightLabel.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: defaulHeight))
        
        weightUnitLabel.anchor(top: weightLabel.topAnchor, leading: weightLabel.trailingAnchor, bottom: weightLabel.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0), size: CGSize(width: defaulHeight, height: 0))
        
        countButton.anchor(top: weightLabel.bottomAnchor, leading: container.leadingAnchor, bottom: container.bottomAnchor, trailing: container.trailingAnchor, padding: UIEdgeInsets(top: 30, left: 30, bottom: -30, right: -30))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
