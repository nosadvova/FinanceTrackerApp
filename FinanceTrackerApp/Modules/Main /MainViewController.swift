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
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private var exchangeRateLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemGray
        label.text = "1 = 12343$"
        
        return label
    }()
    
    private var balanceLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 17)
        label.text = "Balance 0.04455555456 BTC"
        label.textColor = .white
        
        return label
    }()
    
    private lazy var recieveBTCButton: UIButton = {
       let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n.Main.recieve, for: .normal)
        button.backgroundColor = .darkBlue
        button.frame = CGRect(x: 0, y: 0, width: 75, height: 35)
        button.layer.cornerRadius = 9
        button.layer.shadowOpacity = 0.5
        
        button.addTarget(self, action: #selector(recieveBTCButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var addTransactionButton: UIButton = {
       let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .darkGreen
        button.setTitle(L10n.Main.addTransaction, for: .normal)
        
        button.addTarget(self, action: #selector(addTransactionButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let transactionsTableView = UITableView()
    
    private lazy var exchangeRateStackView = setupStackView(views: [btcImageView, exchangeRateLabel], spacing: 15, distribution: .fill)
    private lazy var balanceStackView = setupStackView(views: [balanceLabel, recieveBTCButton])
    
    private var viewModel: MainViewModel!
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViews()
    }
    
    //MARK: - Setup view
    
    override func addContent() {
        super.addContent()
        
        stackView.addSubview(exchangeRateStackView)
        stackView.addArrangedSubview(balanceStackView, withSpacing: -40)
        stackView.addArrangedSubview(balanceStackView, withSpacing: 40)
        stackView.addArrangedSubview(addTransactionButton, withSpacing: 50)
        stackView.addArrangedSubview(transactionsTableView, withSpacing: 40)
    }
    
    override func configureContent() {
        super.configureContent()
        
        view.backgroundColor = .backgroundGray
        balanceLabel.contentCompressionResistancePriority(for: .horizontal)
        transactionsTableView.backgroundColor = .red
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        NSLayoutConstraint.activate([
            
            exchangeRateStackView.topAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.topAnchor),
            exchangeRateStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            
            balanceStackView.topAnchor.constraint(equalTo: exchangeRateStackView.bottomAnchor, constant: 40),
            balanceStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 5),
            balanceStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -5),
            
            addTransactionButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 50),
            addTransactionButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -50),
            
            transactionsTableView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
    }
    
    //MARK: - Functionality
    
    @objc private func recieveBTCButtonTapped() {
        let popupVC = PopupViewController()
        
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        present(popupVC, animated: true, completion: nil)
    }
    
    @objc private func addTransactionButtonTapped() {
        
    }
    
    
}

//MARK: - TableView

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionCell
        
        return cell
    }
}

