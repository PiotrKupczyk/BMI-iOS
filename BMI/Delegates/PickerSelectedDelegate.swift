//
//  PickerSelectedDelegate.swift
//  BMI
//
//  Created by Piotr Kupczyk on 25.06.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//

import Foundation

protocol PickerSelectedDeletage {
    func didSelect(_ sender: BasePickerView, value: String)
}
