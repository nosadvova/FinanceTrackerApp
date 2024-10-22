//
//  VCStackView.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 09.07.2024.
//

import UIKit

// protocol that defines the basic functions for UIViewController

class VCStackViewController: UIViewController, VCInsides {
    public lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        
        return stackView
    }()
    
    func addContent() {
        view.addSubview(stackView)
    }
        
    func configureContent() { /* Default Implementation, override in subclass if needed */ }
    
    func makeConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupStackView(views: [UIView], axis: NSLayoutConstraint.Axis = .horizontal, spacing: CGFloat = 0, distribution: UIStackView.Distribution = .fillEqually) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        views.forEach {
            stackView.addArrangedSubview($0)
        }
        
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.distribution = distribution
        
        return stackView
    }
}
