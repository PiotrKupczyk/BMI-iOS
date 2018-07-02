//
// Created by Piotr Kupczyk on 01.07.2018.
// Copyright (c) 2018 Piotr Kupczyk. All rights reserved.
//

import UIKit

class ResultView: UIStackView {

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.distribution = .fillEqually
        self.axis = .vertical

        self.setupLayout()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

//    override func layoutSubviews() {
//        super.layoutSubviews()
//        underweightNormView.setGradientBackground(colors: [UIColor.BMI.overweight.cgColor, UIColor.BMI.norm.cgColor])
//    }

    private func setupLayout() {
        self.layoutIfNeeded()
        self.addArrangedSubview(resultLabel)
        self.addArrangedSubview(resultIndexContainer)

        resultIndexContainer.addArrangedSubview(underweightView)
        resultIndexContainer.addArrangedSubview(underweightNormView)
        resultIndexContainer.addArrangedSubview(normView)
        resultIndexContainer.addArrangedSubview(normOverweightView)
        resultIndexContainer.addArrangedSubview(overweightView)
        resultIndexContainer.addArrangedSubview(overweightObeseView)
        resultIndexContainer.addArrangedSubview(obeseView)
    }



    let resultLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()

    let resultIndexContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.distribution = .fillEqually
        return stackView
    }()

    //MARK: - result index labels

    let underweightView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.BMI.underweight
        return view
    }()

    let underweightNormView: UIView = {
        let view = UIView()
        view.isHidden = false
        view.setGradientBackground(colors: [UIColor.BMI.underweight.cgColor, UIColor.BMI.norm.cgColor])
        return view
    }()

    let normView: UIView = {
        let label = UIView()
        label.backgroundColor = UIColor.BMI.norm
        return label
    }()

    let normOverweightView: UIView = {
        let view = UIView()
        view.setGradientBackground(colors: [UIColor.BMI.norm.cgColor, UIColor.BMI.overweight.cgColor])
        return view
    }()

    let overweightView: UIView = {
        let label = UIView()
        label.backgroundColor = UIColor.BMI.overweight
        return label
    }()

    let overweightObeseView: UIView = {
        let view = UIView()
        view.setGradientBackground(colors: [UIColor.BMI.overweight.cgColor, UIColor.BMI.obese.cgColor])
        return view
    }()

    let obeseView: UIView = {
        let label = UIView()
        label.backgroundColor = UIColor.BMI.obese
        return label
    }()
}
