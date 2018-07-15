//
//  MetricalHeight.swift
//  BMI
//
//  Created by Piotr Kupczyk on 15.07.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//
import UIKit

class ImperialHeightContainer: MetricalHeightContainer {
    
    override init(delegate: HomeControllerDelegate) {
        super.init(delegate: delegate)
        self.addArrangedSubview(inch)
        setupOnClick()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let inch:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Pass your height"
        //style label
        textField.addUnderline()
        //text format
        textField.textAlignment = .center
        return textField
    }()
    
    fileprivate func setupOnClick() {
        let inchTap = UITapGestureRecognizer(target: self, action: #selector(inchOnClick))
        inch.isUserInteractionEnabled = true
        inch.addGestureRecognizer(inchTap)
    }
    
    @objc fileprivate func inchOnClick() {
        controllerDelegate?.inchClicked()
    }
}
