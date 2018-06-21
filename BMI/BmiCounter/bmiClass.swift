//
//  BmiImperial.swift
//  BMI
//
//  Created by Piotr Kupczyk on 21.06.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//
import Foundation
class BmiCouter {
    
    internal enum BmiErrors: Error {
        case invalidFormat
    }
    
    
    private func checkValue(value: Double, range: ClosedRange<Double>) throws -> Double {
        if range.contains(value) {
            return value
        } else {
            throw BmiErrors.invalidFormat
        }
    }
    
    init(centimeters: Double, kilograms: Double) {
        self.centimeters = centimeters
        self.kilograms = kilograms
    }
    
    init(feet: Double, inches: Double, pounds: Double) {
        self.feet = feet
        self.inches = inches
        self.pounds = pounds
    }
    
    func cout() -> Double {
        return kilograms/(pow(centimeters/100, 2))
    }
    
    func metricToImperial(kg: Double, cm: Double) {
        
    }
    
    private struct Pair<T> {
        let first: T
        let second: T
        init(first: T, second: T) {
            self.first = first
            self.second = second
        }
    }

    

    //------------------------------Values getters and setters---------------------
    
    //metric units
    private var centimeters: Double {
        set(value) {
            let centimetersRange = 60.96...243.84
            do {
                self.inches = try checkValue(value: value, range: centimetersRange)
            } catch BmiErrors.invalidFormat {
                print("Error")
            } catch {
                print("any other")
            }
        }
        get {
            return self.centimeters
        }
        
    }
    private var kilograms: Double {
        
        set(value) {
            let kilogramsRange = 24.95...181.44
            do {
                self.inches = try checkValue(value: value, range: kilogramsRange)
            } catch BmiErrors.invalidFormat {
                print("Error")
            } catch {
                print("any other")
            }
        }
        get {
            return self.kilograms
        }
        
    }
    
    //imperial units
    var feet: Double {
        set(value) {
            let feetRange = 2.0...7.0
            do {
                self.inches = try checkValue(value: value, range: feetRange)
            } catch BmiErrors.invalidFormat {
                print("Error")
            } catch {
                print("any other")
            }
        }
        get {
            return self.feet
        }
    }
    
    var inches: Double {
        set(value) {
            let inchesRange = 0.0...12.0
            do {
                self.inches = try checkValue(value: value, range: inchesRange)
            } catch BmiErrors.invalidFormat {
                print("Error")
            } catch {
                print("any other")
            }
        }
        get {
            return self.inches
        }
    }
    var pounds: Double {
        set(value) {
            let inchesRange = 55.0...400.0
            do {
                self.pounds = try checkValue(value: pounds, range: 55.0...400.0)
            } catch BmiErrors.invalidFormat {
                print("Error")
            } catch {
                print("any other")
            }
        }
        get {
            return self.inches
        }
    }
    }
