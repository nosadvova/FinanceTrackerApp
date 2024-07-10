//
//  UIStackView + Extension.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 09.07.2024.
//

import UIKit

extension UIStackView {
    func addArrangedSubview(_ view: UIView, withSpacing spacing: CGFloat = 0.0) {
        if self.axis == .vertical {
            let spacer = UIView()
            spacer.setContentHuggingPriority(.defaultLow, for: .vertical)
            spacer.translatesAutoresizingMaskIntoConstraints = false
            spacer.heightAnchor.constraint(equalToConstant: spacing).isActive = true
            self.addArrangedSubview(spacer)
            self.sendSubviewToBack(spacer)
        }
        self.addArrangedSubview(view)
    }
}
