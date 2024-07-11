//
//  RoundView.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 10.07.2024.
//

import UIKit

class RoundView: UIView {
    
    // MARK: - Properties
    
    private var height: CGFloat
    
    // MARK: - Init
    init(height: CGFloat) {
        self.height = height
        
        super.init(frame: .zero)

        setupRoundView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup functions
    private func setupRoundView() {
        translatesAutoresizingMaskIntoConstraints = false

        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 4)
        
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
