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

    override func setupViews() {
        self.backgroundColor = .white
        addSubview(container)
        addSubview(resultView)
        
        container.addSubview(valuesContainer)
        
        valuesContainer.addSubview(heightContainer)
        valuesContainer.addSubview(weightContainer)
        valuesContainer.addSubview(countButton)
        
        heightContainer.addSubview(height)
        heightContainer.addSubview(heightLabel)
        
        weightContainer.addSubview(weight)
        weightContainer.addSubview(weightLabel)
        
        let defaultHeight = CGFloat(45)
        let labelWidth = CGFloat(60)
        
        container.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .zero, size: CGSize(width: 0, height: 2*self.bounds.height/3))

        resultView.anchor(top: container.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor)
        
        valuesContainer.anchor(top: container.topAnchor, leading: container.leadingAnchor, bottom: container.bottomAnchor, trailing: container.trailingAnchor, padding: UIEdgeInsets(top: 60, left: 60, bottom: -60, right: -60))
        
        heightContainer.anchor(top: valuesContainer.topAnchor, leading: valuesContainer.leadingAnchor, bottom: nil, trailing: valuesContainer.trailingAnchor, padding: UIEdgeInsets(top: 4, left: 4, bottom: 0, right: -4), size: CGSize(width: 0, height: defaultHeight))
        
        weightContainer.anchor(top: heightContainer.bottomAnchor, leading: heightContainer.leadingAnchor, bottom: nil, trailing: heightContainer.trailingAnchor, padding: UIEdgeInsets(top: 32, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: defaultHeight))
        
        //set up height container
        heightLabel.anchor(top: heightContainer.topAnchor, leading: heightContainer.leadingAnchor, bottom: heightContainer.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: labelWidth, height: defaultHeight))
        
        height.anchor(top: heightContainer.topAnchor, leading: heightLabel.trailingAnchor, bottom: heightContainer.bottomAnchor, trailing: heightContainer.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 45, bottom: 0, right: -8))
        
        //set up weight container
        
        weightLabel.anchor(top: weightContainer.topAnchor, leading: weightContainer.leadingAnchor, bottom: weightContainer.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: labelWidth, height: 0))
        
        weight.anchor(top: weightContainer.topAnchor, leading: weightLabel.trailingAnchor, bottom: weightContainer.bottomAnchor, trailing: weightContainer.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 45, bottom: 0, right: -8))
        
        countButton.anchor(top: weightContainer.bottomAnchor, leading: weightContainer.leadingAnchor, bottom: valuesContainer.bottomAnchor, trailing: weightContainer.trailingAnchor, padding: UIEdgeInsets(top: 60, left: 30, bottom: -60, right: -30))

        setupPickersLayout()

//        setupResultContainerLayout()

//        UIView.animate(withDuration: 0.5, animations: )
    }

    private func setupPickersLayout() {
        addSubview(heightPicker!)
        addSubview(weightPicker!)

        heightPicker?.anchor(top: container.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor)
        weightPicker?.anchor(top: container.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor)
    }

    // MARK: - On Click methods
    override func setupOnClick() {
        let heightTap = UITapGestureRecognizer(target: self, action: #selector(heightOnClick))
        height.isUserInteractionEnabled = true
        height.addGestureRecognizer(heightTap)

        let weightTap = UITapGestureRecognizer(target: self, action: #selector(weightOnClick))
        weight.isUserInteractionEnabled = true
        weight.addGestureRecognizer(weightTap)

        countButton.addTarget(self, action: #selector(countBmi), for: .touchUpInside)
    }

    @objc func heightOnClick() {
        if heightPicker!.isHidden {
            heightPicker?.show()
        }
    }

    @objc func weightOnClick() {
        if weightPicker!.isHidden {
            weightPicker?.show()
        }
    }

    @objc func countBmi() {
        guard let splitedHeight = height.text?.components(separatedBy: " ")[0] else {
            print("There is no height")
            return}
        guard let splitedWeight = weight.text?.components(separatedBy: " ")[0] else {
            print("There is no weight")
            return}

        let bmiCounter = Bmi(centimeters: Double(splitedHeight)!, kilograms: Double(splitedWeight)!)
        let bmi = bmiCounter.count()

        showResult(result: bmi.value)
    }
    
    // MARK: - Set up pickers

    var heightPicker: BasePicker?
    var weightPicker: BasePicker?

    override func setupPickers() {
        heightPicker = BasePicker(data: [Int](120...220), unit: UnitLength.centimeters
                , pickerTag: Tags.heightPicker)
        heightPicker?.pickerData?.collectionDelegate = self

        weightPicker = BasePicker(data: [Int](30...200), unit: UnitMass.kilograms
                , pickerTag: Tags.massPicker)
        weightPicker?.pickerData?.collectionDelegate = self

    }

    //MARK: - picker view changed

    override func didSelect(_ sender: BasePickerData, value: String) {
        switch sender.tag {
        case Tags.heightPicker: do {
            height.text = value
            break
        }
        case Tags.massPicker: do {
            weight.text = value
            break
        }
        default:
            break
        }
    }

    //MARK: - show result

    private func showResult(result: Double) {
        resultView.resultLabel.text = "\(result)"
    }

    

}
