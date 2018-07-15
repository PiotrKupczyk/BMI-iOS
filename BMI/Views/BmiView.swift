//
//  MetricalCollectionViewCell.swift
//  BMI
//
//  Created by Piotr Kupczyk on 23.06.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//

import UIKit

class BmiView: UIView {

    //MARK: - inits
    
    init() {
        super.init(frame: .zero)
        setupPickers()
        setupOnClick()
        addViews()
        setupViews()
        self.backgroundColor = UIColor.AppColors.backgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    //MARK: - Count button
    
    let countButtonView = CountButtonView()
    
    //MARK: - Pickers
    
    var heightPicker: BasePicker?
    var weightPicker: BasePicker?
    
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
        stackView.distribution = .fillEqually
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
    
    fileprivate func addViews() {
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
    
    func setupViews() {
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
    func setupOnClick() {
         countButtonView.countButton.addTarget(self, action: #selector(countBmi), for: .touchUpInside)
    }

    @objc func heightOnClick() {
        if heightPicker!.isHidden {
            self.addDarkBackground()
            heightPicker?.show()
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

    func setupPickers() {
        heightPicker = BasePicker(data: [Int](120...220), unit: UnitLength.centimeters
                , pickerTag: Tags.heightPicker)
        heightPicker?.pickerData?.pickerDelegate = self

        weightPicker = BasePicker(data: [Int](30...200), unit: UnitMass.kilograms
                , pickerTag: Tags.massPicker)
        weightPicker?.pickerData?.pickerDelegate = self

    }

    //MARK: - Delegate methods
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.textColor = .black
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }

    func didSelect(_ sender: BasePickerData, value: String?) {
        // if there was no value selected remove dark backgroud
        guard let value = value else {
            self.mainView.removeDarkBackground()
            return
        }
        switch sender.tag {
        case Tags.heightPicker: do {
            height.text = value
        }
        case Tags.massPicker: do {
            weight.text = value
        }
        default:
            break
        }
        self.mainView.removeDarkBackground()
    }

    //MARK: - Helpers
    
    fileprivate func addDarkBackground() {
        let layer = CAShapeLayer()
        let size = CGSize(width: mainView.bounds.size.width+32, height: mainView.bounds.height+32)
        let rect = CGRect(origin: CGPoint(x: -16, y: -16), size: size)
        let path = UIBezierPath(rect: rect)
        layer.path = path.cgPath
        layer.opacity = 0.2
        layer.fillColor = UIColor.black.cgColor
        mainView.layer.addSublayer(layer)
    }
    
    fileprivate struct Tags {
        static let heightPicker = 0
        static let massPicker = 1
    }

}
