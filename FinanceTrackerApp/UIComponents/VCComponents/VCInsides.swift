//
//  VCInsides.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 09.07.2024.
//

import UIKit

// protocol that defines the basic functions for UIViewController

public protocol VCInsides {
    func loadViews()
    
    func addContent()
    func configureContent()
    
    func makeConstraints()
}

public extension VCInsides {
    func loadViews() {
        addContent()
        configureContent()
        makeConstraints()
    }
    
    func addContent() {}
    
    func configureContent() {}
    
    func makeConstraints() {}
}
