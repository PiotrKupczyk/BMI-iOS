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
        button.addTarget(self, action: #selector(doneClicked()), for: .touchUpInside)
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

    let buttonsContainerView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = UIColor.AppColors.backgroundColor
        return view
    }()

    private var pickerView: BasePickerView

    @objc private func doneClicked() {
        self.isHidden = true
    }

    @objc private func cancelClicked() {
        self.isHidden = true
    }


    init(data: [Int], unit: Unit, pickerTag: Int) {
        self.backgroundColor = UIColor.AppColors.backgroundColor
        pickerView = BasePickerView(data: data, unit: unit, pickerTag: pickerTag)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        self.addSubview(buttonsContainerView)
        self.addSubview(pickerView)

        buttonsContainerView.addSubview(cancelButton)
        buttonsContainerView.addSubview(doneButton)

        buttonsContainerView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: CGSize(width: 0, height: 30))
        pickerView.anchor(top: buttonsContainerView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }

}
