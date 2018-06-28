//
// Created by Piotr Kupczyk on 28.06.2018.
// Copyright (c) 2018 Piotr Kupczyk. All rights reserved.
//

import UIKit

class BasePicker: UIView {

    private let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.isHidden = false
        button.addTarget(self, action: #selector(doneClicked), for: .touchUpInside)
        return button
    }()

    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.isHidden = false
        button.addTarget(self, action: #selector(cancelClicked), for: .touchUpInside)
        return button
    }()

    private let buttonsContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor.black
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isHidden = false
        return stackView
    }()

    let pickerView: UIPickerView = UIPickerView()

    var pickerData: BasePickerData?

    @objc private func doneClicked() {
        self.isHidden = true
    }

    @objc private func cancelClicked() {
        self.isHidden = true
    }

    init(data: [Int], unit: Unit, pickerTag: Int) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

        self.backgroundColor = UIColor.AppColors.backgroundColor
        self.isHidden = true

        setupPicker(data, unit, pickerTag)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupPicker(_ data: [Int], _ unit: Unit, _ pickerTag: Int) {
        pickerData = BasePickerData(data: data, unit: unit, pickerTag: pickerTag)
        pickerView.dataSource = pickerData
        pickerView.delegate = pickerData
    }

    func setupViews() {
        self.addSubview(buttonsContainerView)
        self.addSubview(pickerView)

        buttonsContainerView.addArrangedSubview(cancelButton)
        buttonsContainerView.addArrangedSubview(doneButton)

        buttonsContainerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,
                 padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16), size: CGSize(width: 0, height: 30))
        pickerView.anchor(top: buttonsContainerView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }

}