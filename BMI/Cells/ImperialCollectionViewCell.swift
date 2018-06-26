//
//  ImperialCollectionViewCell.swift
//  BMI
//
//  Created by Piotr Kupczyk on 23.06.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//

import UIKit

class ImperialCollectionViewCell: AbstractCollectionViewCell {

    let inches: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 8
        label.layer.borderColor = UIColor.AppColors.primaryColor.cgColor
        label.layer.borderWidth = 1
        label.clipsToBounds = true
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    struct Tags {
        static let feetPicker = 0
        static let inchesPicker = 1
        static let poundsPicker = 2
    }
    
    // MARK: - Pickers
    
    let feetPickerView: UIPickerView = {
        let view = UIPickerView()
        view.tag = Tags.feetPicker
        view.isHidden = true
        return view
    }()
    
    var inchesPickerView: UIPickerView = {
        let view = UIPickerView()
        view.tag = Tags.inchesPicker
        view.isHidden = true
        return view
    }()
    
    let poundsPickerView: UIPickerView = {
        let view = UIPickerView()
        view.tag = Tags.poundsPicker
        view.isHidden = true
        return view
    }()
    
    // MARK: - Pickers delegates and data sources
    
    var feetPickerDataModel: BasePickerView?
    var inchesPickerDataModel: BasePickerView?
    var poundsPickerDataModel: BasePickerView?
    
    // MARK: - On Click methods
    override func setupOnClick() {
        let heightTap = UITapGestureRecognizer(target: self, action: #selector(heightOnClick))
        height.isUserInteractionEnabled = true
        height.addGestureRecognizer(heightTap)
        
        let inchesTap = UITapGestureRecognizer(target: self, action: #selector(inchesOnClick))
        inches.isUserInteractionEnabled = true
        inches.addGestureRecognizer(inchesTap)
        
        let weightTap = UITapGestureRecognizer(target: self, action: #selector(weightOnClick))
        weight.isUserInteractionEnabled = true
        weight.addGestureRecognizer(weightTap)
    }
    
    @objc func heightOnClick() {
        if feetPickerView.isHidden {
            feetPickerView.isHidden = false
        }
    }
    
    @objc func inchesOnClick() {
        if inchesPickerView.isHidden {
            inchesPickerView.isHidden = false
        }
    }
    
    @objc func weightOnClick() {
        if poundsPickerView.isHidden {
            poundsPickerView.isHidden = false
        }
    }
    
    
    // MARK: - Pickers methods
    
    override func setupPickers() {
        feetPickerDataModel = BasePickerView(data: [Int](1...7), unit: UnitLength.feet, pickerTag: Tags.feetPicker)
        feetPickerView.dataSource = feetPickerDataModel
        feetPickerView.delegate = feetPickerDataModel
        feetPickerDataModel?.collectionDelegate = self
        
        inchesPickerDataModel = BasePickerView(data: [Int](0...11), unit: UnitLength.inches, pickerTag: Tags.inchesPicker)
        inchesPickerView.dataSource = inchesPickerDataModel
        inchesPickerView.delegate = inchesPickerDataModel
        inchesPickerDataModel?.collectionDelegate = self
        
        poundsPickerDataModel = BasePickerView(data: [Int](80...280), unit: UnitMass.pounds, pickerTag: Tags.poundsPicker)
        poundsPickerView.dataSource = poundsPickerDataModel
        poundsPickerView.delegate = poundsPickerDataModel
        poundsPickerDataModel?.collectionDelegate = self
    }
    
    // MARK: - PickerView changed
    
    override func didSelect(_ sender: BasePickerView, value: String) {
        switch sender.tag {
        case Tags.feetPicker: do {
            height.text = value
            feetPickerView.isHidden = true
            break
        }
        case Tags.inchesPicker: do {
            inches.text = value
            inchesPickerView.isHidden = true
            break
            }
        case Tags.poundsPicker: do {
            weight.text = value
            poundsPickerView.isHidden = true
            break
            }
        default:
            break
        }
    }
    
    // MARK: - Layout

    override func setupViews() {
        addSubview(container)
        addSubview(resultLabel)
        addSubview(feetPickerView)
        addSubview(inchesPickerView)
        addSubview(poundsPickerView)
        
        container.addSubview(valuesContainer)
        
        valuesContainer.addSubview(heightContainer)
        valuesContainer.addSubview(weightContainer)
        valuesContainer.addSubview(countButton)
        
        heightContainer.addSubview(height)
        heightContainer.addSubview(heightLabel)
        heightContainer.addSubview(inches)
        
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
        
        height.anchor(top: heightContainer.topAnchor, leading: heightLabel.trailingAnchor, bottom: heightContainer.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 0), size: CGSize(width: 60, height: 0))
        
        inches.anchor(top: heightContainer.topAnchor, leading: height.trailingAnchor, bottom: heightContainer.bottomAnchor, trailing: heightContainer.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8))
        
        //set up weight container
        
        weightLabel.anchor(top: weightContainer.topAnchor, leading: weightContainer.leadingAnchor, bottom: weightContainer.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: labelWidth, height: 0))
        
        weight.anchor(top: weightContainer.topAnchor, leading: weightLabel.trailingAnchor, bottom: weightContainer.bottomAnchor, trailing: weightContainer.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 45, bottom: 0, right: -8))
        
        countButton.anchor(top: weightContainer.bottomAnchor, leading: weightContainer.leadingAnchor, bottom: valuesContainer.bottomAnchor, trailing: weightContainer.trailingAnchor, padding: UIEdgeInsets(top: 60, left: 30, bottom: -60, right: -30))
        
        //set up pickers
        feetPickerView.anchor(top: container.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor)
        
        inchesPickerView.anchor(top: container.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor)
        
        poundsPickerView.anchor(top: container.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor)
    }
}
