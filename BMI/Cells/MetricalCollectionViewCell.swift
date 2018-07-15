//
//  MetricalCollectionViewCell.swift
//  BMI
//
//  Created by Piotr Kupczyk on 23.06.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//

import UIKit

class MetricalCollectionViewCell: BaseCell {

    private struct Tags {
        static let heightPicker = 0
        static let massPicker = 1
    }

    override func setupViews() {
        super.setupViews()
        mainView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: -16, right: -16))
        heightContainer.addArrangedSubview(heightLabel)
        heightContainer.addArrangedSubview(height)
        setupPickersLayout()
    }

    private func setupPickersLayout() {
        addSubview(heightPicker!)
        addSubview(weightPicker!)

        heightPicker?.anchor(top: resultView.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor)
        weightPicker?.anchor(top: resultView.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor)
    }

    // MARK: - On Click methods
    override func setupOnClick() {
        let heightTap = UITapGestureRecognizer(target: self, action: #selector(heightOnClick))
        height.isUserInteractionEnabled = true
        height.addGestureRecognizer(heightTap)

        let weightTap = UITapGestureRecognizer(target: self, action: #selector(weightOnClick))
        weight.isUserInteractionEnabled = true
        weight.addGestureRecognizer(weightTap)

         countButtonView.countButton.addTarget(self, action: #selector(countBmi), for: .touchUpInside)
    }

    @objc func heightOnClick() {
        if heightPicker!.isHidden {
            self.addDarkBackground()
            heightPicker?.show()
            print("clicked")
        }
    }

    @objc func weightOnClick() {
        if weightPicker!.isHidden {
            self.addDarkBackground()
            weightPicker?.show()
        }
    }

    @objc func countBmi() {
        self.countButtonView.buttonUp()
        guard let splitedHeight = height.text?.components(separatedBy: " ")[0] else {return}
        guard let splitedWeight = weight.text?.components(separatedBy: " ")[0] else {return}
        
        if (splitedWeight.isEmpty) || (splitedHeight.isEmpty) {
            print("empty")
            return
        }
        
        let bmiCounter = Bmi(centimeters: Double(splitedHeight)!, kilograms: Double(splitedWeight)!)
        let bmi = bmiCounter.count()
        resultView.showResult(bmi: bmi)
    }
    
    // MARK: - Set up pickers

    var heightPicker: BasePicker?
    var weightPicker: BasePicker?

    override func setupPickers() {
        heightPicker = BasePicker(data: [Int](120...220), unit: UnitLength.centimeters
                , pickerTag: Tags.heightPicker)
        heightPicker?.pickerData?.pickerDelegate = self

        weightPicker = BasePicker(data: [Int](30...200), unit: UnitMass.kilograms
                , pickerTag: Tags.massPicker)
        weightPicker?.pickerData?.pickerDelegate = self

    }

    //MARK: - picker view changed

    override func didSelect(_ sender: BasePickerData, value: String?) {
        guard let value = value else {
            self.mainView.removeDarkBackground()
            return
        }
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
        self.mainView.removeDarkBackground()
    }

    

}
