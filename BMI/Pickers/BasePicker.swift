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

    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()

    let pickerView: UIPickerView = UIPickerView()

    var pickerData: BasePickerData?

    @objc private func doneClicked() {
        self.isHidden = true
        pickerData?.notifyAboutResult(state: .done)
    }

    @objc private func cancelClicked() {
        self.isHidden = true
        pickerData?.notifyAboutResult(state: .cancel)
    }

    init(data: [Int], unit: Unit, pickerTag: Int) {
        super.init(frame: .zero)

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
        self.addSubview(separator)

        buttonsContainerView.addArrangedSubview(cancelButton)
        buttonsContainerView.addArrangedSubview(doneButton)

        buttonsContainerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,
                 padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: -16), size: CGSize(width: 0, height: 30))
        separator.anchor(top: buttonsContainerView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,
                padding: UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 1))
        pickerView.anchor(top: separator.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }

    func show() {
        self.transform = CGAffineTransform(translationX: 0, y: self.bounds.height)
        self.isHidden = false

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.transform = self.transform.translatedBy(x: 0, y: -self.bounds.height)
        }, completion: nil)
    }


}
