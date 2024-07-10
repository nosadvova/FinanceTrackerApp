//
//  ChevronView.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 10.07.2024.
//

import UIKit

class SGExpandableChevronView: UIView {
    
    // MARK: Properties

    private let titleLabel: CustomLabel
    var infoLabel: CustomLabel
        
    private var chevronImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    // MARK: Init
    init(titleLabel: String, infoLabel: String) {
        self.titleLabel = CustomLabel(type: .primary(text: titleLabel, font: .systemFont(ofSize: 12)))
        self.infoLabel = CustomLabel(type: .primary(text: infoLabel, font: .boldSystemFont(ofSize: 16)))
                
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup functions
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
                
        self.addSubview(titleLabel)
        self.addSubview(infoLabel)
        self.addSubview(chevronImageView)
        
        setupViewConstraints()
    }
    
    private func setupViewConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            infoLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -80),
            infoLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            chevronImageView.widthAnchor.constraint(equalToConstant: 24),
            chevronImageView.heightAnchor.constraint(equalToConstant: 24),
            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            chevronImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    // MARK: - Update UI functions
    func chevronViewTapped() {
        self.chevronImageView.transform = self.chevronImageView.transform.rotated(by: .pi)
    }
}
