//
//  BasePickerData.swift
//  BMI
//
//  Created by Piotr Kupczyk on 25.06.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//

import UIKit

class BasePickerData: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var data: [Int]?
    var unit: Unit?
    var collectionDelegate: PickerSelectedDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(data: [Int], unit: Unit, pickerTag: Int) {
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
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
        return "\(data![row]) \(unit!.symbol)"
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        collectionDelegate?.didSelect(self, value: "\(data![row]) \(unit!.symbol)")
    }
}
