//
//  CustomLabel.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 10.07.2024.
//

import UIKit

class CustomLabel: UILabel {
    
    var edgeInset: UIEdgeInsets = .zero
    
    enum LabelType {
        case primary(text: String, font: UIFont? = nil)
    }
    
    // MARK: Init
    init(type: LabelType) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        switch type {
        case .primary(let text, let font):
            setupLabel(with: text, font: font)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup funcs
    private func setupLabel(with text: String, font: UIFont?) {
        self.textColor = .black
        self.font = font
        self.text = text
    }
    
    //MARK: - Ability to change padding around label

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: edgeInset.top, left: edgeInset.left, bottom: edgeInset.bottom, right: edgeInset.right)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + edgeInset.left + edgeInset.right, height: size.height + edgeInset.top + edgeInset.bottom)
    }
}
