//
//  File.swift
//  BMI
//
//  Created by Piotr Kupczyk on 12.07.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//

import Foundation
import UIKit
enum BmiIndex: String {
    case underweight = "Underweight"
    case norm = "Norm"
    case overweight = "Overweight"
    case obese = "Obese"
    
    static let allCases = [underweight, norm, overweight, obese]
    
    var color: UIColor {
        get {
            switch self {
            case .underweight:
                return UIColor.BMI.underweight
            case .norm:
                return UIColor.BMI.norm
            case .overweight:
                return UIColor.BMI.overweight
            case .obese:
                return UIColor.BMI.obese
            }
        }
    }
    
    var stringRange: String {
        get {
            switch self {
            case .underweight:
                return "6.0-18.5"
            case .norm:
                return "18.5-25"
            case .overweight:
                return "25-30"
            case .obese:
                return "> 30"
            }
        }
    }
    var range: Range<Double> {
        get {
            let underweight = 18.5
            let norm = 25.0
            let overweight = 30.0
            let obese = Double.infinity
    
            switch self {
                case .underweight:
                    return 6.0..<underweight
                case .norm:
                    return underweight..<norm
                case .overweight:
                    return norm..<overweight
                case .obese:
                    return overweight..<obese
            }
        }
    }
}
