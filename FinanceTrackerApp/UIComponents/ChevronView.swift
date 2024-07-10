//
//  ChevronView.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 10.07.2024.
//

import UIKit

class ChevronView: UIView, VCInsides {
    //MARK: - Properties
    
    private var chevronImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        
        loadViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup view
    func addContent() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(chevronImageView)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            chevronImageView.widthAnchor.constraint(equalToConstant: 24),
            chevronImageView.heightAnchor.constraint(equalToConstant: 24),
            chevronImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            chevronImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    // MARK: - Update UI functions
    func chevronViewTapped() {
        self.chevronImageView.transform = self.chevronImageView.transform.rotated(by: .pi)
    }
}
