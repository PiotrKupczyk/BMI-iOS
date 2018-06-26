//
//  MetricalCollectionViewCell.swift
//  BMI
//
//  Created by Piotr Kupczyk on 23.06.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//

import UIKit

class MetricalCollectionViewCell: AbstractCollectionViewCell {

    private struct Tags {
        static let heightPicker = 0
        static let massPicker = 1
    }

    private let heightPickerView: UIPickerView = {
        let view = UIPickerView()
        view.tag = Tags.heightPicker
        view.isHidden = true
        return view
    }()

    private let weightPickerView: UIPickerView = {
        let view = UIPickerView()
        view.tag = Tags.massPicker
        view.isHidden = true
        return view
    }()

    override func setupViews() {
        addSubview(container)
        addSubview(resultLabel)
        addSubview(heightPickerView)
        addSubview(weightPickerView)
        
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

    // MARK: - On Click methods
    override func setupOnClick() {
        let heightTap = UITapGestureRecognizer(target: self, action: #selector(heightOnClick))
        height.isUserInteractionEnabled = true
        height.addGestureRecognizer(heightTap)

        let weightTap = UITapGestureRecognizer(target: self, action: #selector(weightOnClick))
        weight.isUserInteractionEnabled = true
        weight.addGestureRecognizer(weightTap)
    }

    @objc func heightOnClick() {
        if heightPickerView.isHidden {
            heightPickerView.isHidden = false
        }
    }

    @objc func weightOnClick() {
        if weightPickerView.isHidden {
            weightPickerView.isHidden = false
        }
    }
    
    // MARK: - Set up pickers

    var heightPickerDataModel: BasePickerView?
    var weightPickerDataModel: BasePickerView?

    override func setupPickers() {
        heightPickerDataModel = BasePickerView(data: [Int](120...220), unit: UnitLength.centimeters
                , pickerTag: Tags.heightPicker)
        heightPickerView.dataSource = heightPickerDataModel
        heightPickerView.delegate = heightPickerDataModel
        heightPickerDataModel?.collectionDelegate = self

        weightPickerDataModel = BasePickerView(data: [Int](30...200), unit: UnitMass.kilograms
                , pickerTag: Tags.massPicker)
        weightPickerView.dataSource = weightPickerDataModel
        weightPickerView.delegate = weightPickerDataModel
        weightPickerDataModel?.collectionDelegate = self

    }

    //MARK: - picker view changed

    override func didSelect(_ sender: BasePickerView, value: String) {
        switch sender.tag {
        case Tags.heightPicker: do {
            height.text = value
            heightPickerView.isHidden = true
            break
        }
        case Tags.massPicker: do {
            weight.text = value
            weightPickerView.isHidden = true
            break
        }
        default:
            break
        }
    }

    

}
