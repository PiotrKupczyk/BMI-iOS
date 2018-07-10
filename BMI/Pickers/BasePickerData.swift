//
//  BasePickerData.swift
//  BMI
//
//  Created by Piotr Kupczyk on 25.06.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//

import UIKit

class BasePickerData: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var data: [Int]
    var unit: Unit
    var pickerDelegate: PickerSelectedDelegate?
    var result = ""
    
    override init(frame: CGRect) {
        data = [Int]()
        unit = Unit.init(symbol: "kg")
        super.init(frame: frame)
    }

    convenience init(data: [Int], unit: Unit, pickerTag: Int) {
        self.init(frame: .zero)
        self.data = data
        self.unit = unit
        self.tag = pickerTag
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(data[row]) \(unit.symbol)"
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        result = "\(data[row]) \(unit.symbol)"
    }
    
    public func notifyAboutResult(state: ButtonState) {
        switch state {
        case .done:
            pickerDelegate?.didSelect(self, value: result)
        case .cancel:
            pickerDelegate?.didSelect(self, value: nil)
        }
    }
    
    public enum ButtonState {
        case cancel
        case done
    }
    
}
