//
//  AbstractCollectionViewCell.swift
//  BMI
//
//  Created by Piotr Kupczyk on 23.06.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell, PickerSelectedDelegate, UITextFieldDelegate {    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupPickers()
        setupOnClick()
        setupViews()
        self.backgroundColor = UIColor.AppColors.backgroundColor
        height.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //Mark: - height
    
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

    //MARK: - weight

    let weight:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Pass your weight"
        //style label
        textField.addUnderline()
        //text format
        textField.textAlignment = .center
        return textField
    }()

    let weightLabel:UILabel = {
        let label = UILabel()
        label.text = "Weight"
        label.textAlignment = .left
        label.backgroundColor = .clear
        return label
    }()

    //MARK: - count and result
    
    let countButtonView = CountButtonView()
//    let countButton: UIButton = {
//        let button = UIButton()
//        button.titleLabel?.text = "Counter BMI"
//        button.setTitle("Count", for: UIControlState.normal)
//        button.setTitleColor(.black, for: .normal)
//        button.titleLabel?.textColor = .black
//        button.sizeToFit()
//        DispatchQueue.main.async {
//            let size = button.bounds.size
//            let newSize = min(size.height, size.width)
//            button.frame.size = CGSize(width: newSize, height: newSize)
//            button.layer.cornerRadius = newSize/2
//        }
//        button.clipsToBounds = true
//        button.backgroundColor = UIColor.AppColors.primaryColor
//        return button
//    }()

    //MARK: - Containers

    let mainView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = {
            if UIDevice.current.orientation.isLandscape {return .horizontal}
            else {return .vertical}
        }()
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    let upperContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
//        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    let heightContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let weightContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    let resultView = ResultView()
    
    // MARK: - To override methods
    
    func setupViews() {
        self.addSubview(mainView)
        mainView.addArrangedSubview(upperContainer)
        mainView.addArrangedSubview(resultView)
        
        //MARK: -setup upperContainer
        upperContainer.addArrangedSubview(heightContainer)
        upperContainer.addArrangedSubview(weightContainer)
        upperContainer.addArrangedSubview(countButtonView)
        
        //MARK: - setup weightContainer
        weightContainer.addArrangedSubview(weightLabel)
        weightContainer.addArrangedSubview(weight)
    }
    
    func setupPickers() {
        fatalError("Must override")
    }
    
    func setupOnClick() {
        fatalError("Must override")
    }

    func didSelect(_ sender: BasePickerData, value: String?) {
        fatalError("Must override")
    }
    
    //MARK: - edit text field
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.textColor = .black
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }

}
