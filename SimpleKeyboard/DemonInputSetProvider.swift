//
//  DemoInputSetProvider.swift
//  KeyboardUnicode
//
//  Created by Peter on 26/05/22.
//  Based on KeyboardKitDemo by Daniel Saidi on 2020-06-22.
//

import KeyboardKit

/**
 This demo-specific input set provider replaces the standard
 English alphabetical input set with a unicode one.
 
 For some unicode keyboards, numeric and symbolic input sets
 make no sense. If so, you should create a custom layout and
 remove the numeric/symbolic switches.
 */
class DemoInputSetProvider: DeviceSpecificInputSetProvider {
    
    let baseProvider = EnglishInputSetProvider()
    
    var alphabeticInputSet: AlphabeticInputSet {
        AlphabeticInputSet(rows: [
            row(lowercased: "qẅëṛẗÿüïöṗ", uppercased: "QẄЁṚṪŸÜЇÖṖ"),
            row(lowercased: "äṡḋḟġḧjḳḷ", uppercased: "ÄṠḊḞĠḦJḲḶ"),
            row(
                phoneLowercased: "żẍċṿḅṅṁ",
                phoneUppercased: "ŻẌĊṾḄṄṀ",
                padLowercased: "żẍċṿḅṅṁ,.",
                padUppercased: "ŻẌĊṾḄṄṀ,.")
        ])
    }
    
    var numericInputSet: NumericInputSet {
        baseProvider.numericInputSet
    }
    
    var symbolicInputSet: SymbolicInputSet {
        baseProvider.symbolicInputSet
    }
}
