//
//  RoundView.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 10.07.2024.
//

import UIKit

class RoundView: UIView {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel?
    private var height: CGFloat
    private let viewBackgroundColor: UIColor
    private let viewTintColor: UIColor
    
    // MARK: - Init
    
    init(titleLabel: String? = nil, height: CGFloat, viewBackgroundColor: UIColor = .white, viewTintColor: UIColor = .black) {
        self.titleLabel = titleLabel != nil ? UILabel() : nil
        self.height = height
        self.viewBackgroundColor = viewBackgroundColor
        self.viewTintColor = viewTintColor
        
        super.init(frame: .zero)

        setupRoundView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup view
    private func setupRoundView() {
        translatesAutoresizingMaskIntoConstraints = false

        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 4)
        
        heightAnchor.constraint(equalToConstant: height).isActive = true
        
        if let titleLabel = titleLabel {
            self.addSubview(titleLabel)
            
            titleLabel.textColor = .systemGray2
            titleLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -10).isActive = true
        }
    }
}
