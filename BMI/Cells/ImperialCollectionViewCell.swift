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
    
    var feetPicker: BasePicker?
    var inchesPicker: BasePicker?
    var poundsPicker: BasePicker?
    
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

        countButton.addTarget(self, action: #selector(countBmi), for: .touchUpInside)
    }
    
    @objc func heightOnClick() {
        if (feetPicker?.isHidden)! {
            feetPicker?.show()
        }
    }
    
    @objc func inchesOnClick() {
        if (inchesPicker?.isHidden)! {
            inchesPicker?.show()
        }
    }

    @objc func weightOnClick() {
        if (poundsPicker?.isHidden)! {
            poundsPicker?.show()
        }
    }

    @objc func countBmi() {
        guard let splitedFeet = height.text?.components(separatedBy: " ")[0] else {
            print("There is no height")
            return}

        guard let splitedInch = inches.text?.components(separatedBy: " ")[0] else {
            print("There is no weight")
            return}

        guard let splitedWeight = weight.text?.components(separatedBy: " ")[0] else {
            print("There is no weight")
            return}

        let bmiCounter = Bmi(feet: Double(splitedFeet)!, inches: Double(splitedInch)!, pounds: Double(splitedWeight)!)
        let bmi = bmiCounter.count()

        resultLabel.text = "\(bmi)"
    }

    // MARK: - Pickers methods
    
    override func setupPickers() {
        feetPicker = BasePicker(data: [Int](1...7), unit: UnitLength.feet, pickerTag: Tags.feetPicker)
        feetPicker?.pickerData?.collectionDelegate = self
        
        inchesPicker = BasePicker(data: [Int](0...11), unit: UnitLength.inches, pickerTag: Tags.inchesPicker)
        inchesPicker?.pickerData?.collectionDelegate = self
        
        poundsPicker = BasePicker(data: [Int](88...330), unit: UnitMass.pounds, pickerTag: Tags.poundsPicker)
        poundsPicker?.pickerData?.collectionDelegate = self
    }
    
    // MARK: - PickerView changed
    
    override func didSelect(_ sender: BasePickerData, value: String) {
        switch sender.tag {
        case Tags.feetPicker: do {
            height.text = value
            break
        }
        case Tags.inchesPicker: do {
            inches.text = value
            break
            }
        case Tags.poundsPicker: do {
            weight.text = value
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
        addSubview(feetPicker!)
        addSubview(inchesPicker!)
        addSubview(poundsPicker!)
        
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
        feetPicker?.anchor(top: container.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor)
        
        inchesPicker?.anchor(top: container.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor)
        
        poundsPicker?.anchor(top: container.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor)
    }
}
