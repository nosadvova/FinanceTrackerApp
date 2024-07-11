//
//  Double + Extension.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 11.07.2024.
//

import Foundation

extension Double {
    func formattedToDecimalPlaces(to decimal: Int) -> String {
        return String(format: "%.\(decimal)f", self)
    }
}
