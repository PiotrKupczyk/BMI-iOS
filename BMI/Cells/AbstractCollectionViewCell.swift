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
        setupViews()
        setupPickers()
        setupOnClick()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let heightLabel:UILabel = {
        let label = UILabel()
        label.text = "Height"
        label.textAlignment = .left
        label.backgroundColor = .white
        return label
    }()
    
    let weightLabel:UILabel = {
        let label = UILabel()
        label.text = "Weight"
        label.textAlignment = .left
        label.backgroundColor = .white
        return label
    }()
    
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
    
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "BMI here"
        label.textAlignment = .center
        return label
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

    func didSelect(_ sender: BasePickerView, value: String) {
        fatalError("Must override")
    }

}
