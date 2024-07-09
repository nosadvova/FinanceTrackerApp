//
//  ViewController.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 08.07.2024.
//

import UIKit

class MainViewController: VCStackViewController {
    
    //MARK: - Properties
    
    private var btcImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "btc")
        imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        
        return imageView
    }()
    
    private var exchangeRateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24)
        label.textColor = .systemGray2
        
        return label
    }()
    
    private var balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 25)
        
        return label
    }()
    
    private lazy var recieveBTCButton: UIButton = {
       let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n.Main.recieve, for: .normal)
        button.backgroundColor = .darkBlue
//        button.widthAnchor.constraint(equalToConstant: 75).isActive = true
//        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
        button.frame = CGRect(x: 0, y: 0, width: 75, height: 35)
        
        button.addTarget(self, action: #selector(recieveBTCButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadViews()
    }
    
    //MARK: - Setup view
    
    override func addContent() {
        
    }
    
    override func configureContent() {
        
    }
    
    override func makeConstraints() {
        <#code#>
    }
    
    //MARK: - Functionality
    
    @objc private func recieveBTCButtonTapped() {
        
    }
    
    
}

