//
//  BaseHeightContainer.swift
//  BMI
//
//  Created by Piotr Kupczyk on 15.07.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//

import UIKit

class MetricalHeightContainer: UIStackView {
    var controllerDelegate: HomeControllerDelegate?
    
    init(delegate: HomeControllerDelegate) {
        super.init(frame: .zero)
        setupView()
        setupOnClick()
        self.controllerDelegate = delegate
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        self.backgroundColor = .clear
        self.axis = .horizontal
        self.distribution = .fillEqually
        
        self.addArrangedSubview(heightLabel)
        self.addArrangedSubview(height)
    }
    
    let height:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Pass your height"
        //style label
        textField.addUnderline()
        //text format
        textField.textAlignment = .center
        return textField
    }()
    
    let heightLabel:UILabel = {
        let label = UILabel()
        label.text = "Height"
        label.textAlignment = .left
        label.backgroundColor = .clear
        return label
    }()
    
    fileprivate func setupOnClick() {
        let heightTap = UITapGestureRecognizer(target: self, action: #selector(heightClicked))
        height.isUserInteractionEnabled = true
        height.addGestureRecognizer(heightTap)
    }
    
    //MARK: - Inch on click
    @objc fileprivate func heightClicked() {
        controllerDelegate?.heightClicked()
    }
}
