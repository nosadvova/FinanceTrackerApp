//
//  DateFromatter + Extension.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 09.07.2024.
//

import UIKit

extension DateFormatter {
    static let MMddyy: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "MMM dd, YYYY"
        
        return formatter
    }()
}
