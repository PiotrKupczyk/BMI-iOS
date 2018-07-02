//
//  AbstractCollectionViewCell.swift
//  BMI
//
//  Created by Piotr Kupczyk on 23.06.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//

import UIKit

class AbstractCollectionViewCell: UICollectionViewCell, PickerSelectedDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPickers()
        setupOnClick()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var bmiCounter: Bmi?

    //Mark: - height

    let height:UILabel = {
        let label = UILabel()
        //style label
        label.layer.cornerRadius = 8
        label.layer.borderColor = UIColor.AppColors.primaryColor.cgColor
        label.layer.borderWidth = 1
        label.clipsToBounds = true
        label.backgroundColor = .white
        //text format
        label.textAlignment = .center
        return label
    }()

    let heightLabel:UILabel = {
        let label = UILabel()
        label.text = "Height"
        label.textAlignment = .left
        label.backgroundColor = .white
        return label
    }()

    //MARK: - weight

    let weight: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 8
        label.layer.borderColor = UIColor.AppColors.primaryColor.cgColor
        label.layer.borderWidth = 1
        label.clipsToBounds = true
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()

    let weightLabel:UILabel = {
        let label = UILabel()
        label.text = "Weight"
        label.textAlignment = .left
        label.backgroundColor = .white
        return label
    }()

    //MARK: - count and result
    
    let countButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Counter BMI"
        button.setTitle("Count", for: UIControlState.normal)
        button.setTitleColor(.black, for: UIControlState.normal)
        button.titleLabel?.textColor = .black
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.backgroundColor = UIColor.AppColors.primaryColor
        return button
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()

    //MARK: - Containers

    let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let valuesContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let heightContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let weightContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    let resultView = ResultView()

//    let resultIndexContainer: UIStackView = {
//        let stackView = UIStackView()
//        stackView.backgroundColor = .white
//        stackView.distribution = .fillEqually
//        stackView.isLayoutMarginsRelativeArrangement = true
//        stackView.layoutMargins = UIEdgeInsets(top: 4, left: 4, bottom: 0, right: 4)
//        stackView.spacing = 8
//        return stackView
//    }()
//
//    //MARK: - result index labels
//
//    let underweightLabel: UILabel = {
//        let label = UILabel()
//        label.backgroundColor = UIColor.BMI.underweight
//        label.text = "Underweight"
//        label.textAlignment = .center
//        return label
//    }()
//
//    let normLabel: UILabel = {
//        let label = UILabel()
//        label.backgroundColor = UIColor.BMI.norm
//        label.text = "Norm"
//        label.textAlignment = .center
//        return label
//    }()
//
//    let overweightLabel: UILabel = {
//        let label = UILabel()
//        label.backgroundColor = UIColor.BMI.overweight
//        label.text = "Overweight"
//        label.textAlignment = .center
//        return label
//    }()
//
//    let obeseLabel: UILabel = {
//        let label = UILabel()
//        label.backgroundColor = UIColor.BMI.obese
//        label.text = "Obese"
//        label.textAlignment = .center
//        return label
//    }()
    
    // MARK: - To override methods
    
    func setupViews() {
        fatalError("Must override")
    }
    
    func setupPickers() {
        fatalError("Must override")
    }
    
    func setupOnClick() {
        fatalError("Must override")
    }

    func didSelect(_ sender: BasePickerData, value: String) {
        fatalError("Must override")
    }

}
