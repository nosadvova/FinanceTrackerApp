//
//  String + Extension.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 10.07.2024.
//

import UIKit

extension String {
    func replaceWithDot() -> String {
        self.replacingOccurrences(of: ",", with: ".")
    }
}
