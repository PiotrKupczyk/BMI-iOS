//
//  BmiImperial.swift
//  BMI
//
//  Created by Piotr Kupczyk on 21.06.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//
import Foundation
import UIKit
class Bmi {
    public typealias BmiResult = (value: Double, index: BmiIndex)
    
    init(centimeters: Double, kilograms: Double) {
        self.centimeters = Measurement(value: centimeters, unit: UnitLength.centimeters)
        self.kilograms = Measurement(value: kilograms, unit: UnitMass.kilograms)
        self.pounds = self.kilograms.converted(to: UnitMass.pounds)
        let tempFeet = self.centimeters.converted(to: UnitLength.feet)
        let inchAsPartOfFeet = Measurement(value: tempFeet.value.truncatingRemainder(dividingBy: 1), unit: UnitLength.feet)
        self.feet = Measurement(value: floor(tempFeet.value), unit: UnitLength.feet)
        self.inches = Measurement(value: round(inchAsPartOfFeet.value), unit: UnitLength.inches)
    }
    
    init(feet: Double, inches: Double, pounds: Double) {
        self.feet = Measurement(value: feet, unit: UnitLength.feet)
        self.inches = Measurement(value: inches, unit: UnitLength.inches)
        self.pounds = Measurement(value: pounds, unit: UnitMass.pounds)
        self.centimeters = self.feet.converted(to: UnitLength.centimeters)
                            + self.inches.converted(to: UnitLength.centimeters)
        self.kilograms = self.pounds.converted(to: UnitMass.kilograms)

    }
    
    func count() -> BmiResult {
        //mass in kg / height^2 in meters
        let bmi = kilograms.value/(pow(centimeters.converted(to: UnitLength.meters).value, 2))
        let bmiIndex = indexFromValue(bmi: bmi)
        return BmiResult(value: bmi.roundTo(places: 2), index: bmiIndex!)
    }

    private func indexFromValue(bmi: Double) -> BmiIndex? {
        for bmiIndex in BmiIndex.allCases {
            if bmiIndex.range.contains(bmi) {
                return bmiIndex
            }
        }
        return nil
    }

    
    
    //metric units
    private var centimeters: Measurement<Dimension>
    private var kilograms: Measurement<Dimension>
    
    //imperial units
    var feet: Measurement<Dimension>
    var inches: Measurement<Dimension>
    var pounds: Measurement<Dimension>

}
