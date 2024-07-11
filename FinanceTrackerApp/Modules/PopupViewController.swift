//
//  PopupViewController.swift
//  FinanceTrackerApp
//
//  Created by Vova Novosad on 10.07.2024.
//

import UIKit

protocol RecieveBTCDelegate: AnyObject {
    func recieveBTC(_ amount: Double)
    func addRecieveTransaction(_ transaction: TransactionModel)
}

class PopupViewController: VCStackViewController {
    
    // MARK: - Properties
    
    weak var delegate: RecieveBTCDelegate?
    weak var transactionDelegate: AddTransactionDelegate?
    
    private lazy var darkView: UIView = {
        let view = UIView()
        view.alpha = 1
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissActionSheet))
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    private lazy var popupContainerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .stoneGray
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.cornerRadius = 9
        view.clipsToBounds = true
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n.Main.enterDepositAmount
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var amountTextField: NumpadTextField = {
        let textField = NumpadTextField()
        
        textField.placeholder = L10n.Main.amount
        
        let tfAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "",
                                                             attributes: tfAttributes)
        
        return textField
    }()
        
    private lazy var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(L10n.Main.submit, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 9
        button.tintColor = .white
        button.backgroundColor = .darkBlue
        
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViews()
    }
    
    // MARK: - Setup View
    
    override func addContent() {
        super.addContent()
        
        stackView.addArrangedSubview(darkView)
        stackView.addSubview(popupContainerView)
        popupContainerView.addSubview(titleLabel)
        popupContainerView.addSubview(amountTextField)
        popupContainerView.addSubview(submitButton)
    }
    
    override func configureContent() {
        super.configureContent()
        
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        NSLayoutConstraint.activate([
            
            darkView.widthAnchor.constraint(equalTo: view.widthAnchor),
            darkView.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            popupContainerView.centerXAnchor.constraint(equalTo: darkView.centerXAnchor),
            popupContainerView.centerYAnchor.constraint(equalTo: darkView.centerYAnchor),
            popupContainerView.heightAnchor.constraint(equalToConstant: 250),
            popupContainerView.widthAnchor.constraint(equalToConstant: 350),
            
            titleLabel.topAnchor.constraint(equalTo: popupContainerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: popupContainerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: popupContainerView.trailingAnchor, constant: -20),
            
            amountTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            amountTextField.leadingAnchor.constraint(equalTo: popupContainerView.leadingAnchor, constant: 20),
            amountTextField.trailingAnchor.constraint(equalTo: popupContainerView.trailingAnchor, constant: -20),
            amountTextField.heightAnchor.constraint(equalToConstant: 42),
                        
            submitButton.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 40),
            submitButton.centerXAnchor.constraint(equalTo: popupContainerView.centerXAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 45),
            submitButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func dismissActionSheet() {
        self.dismiss(animated: true)
    }
    
    @objc private func submitButtonTapped() {
        guard let amountText = amountTextField.text, !amountText.isEmpty else {
            return
        }
        
        let redactedString = amountText.replaceWithDot()
        
        
        if let amount = Double(redactedString) {
            let transaction = TransactionModel(
                id: UUID(),
                transactionType: .recieve,
                timestamp: Date(),
                amount: amount
            )
            
            delegate?.recieveBTC(amount)
            saveTransaction(transaction)
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func saveTransaction(_ transaction: TransactionModel) {
        delegate?.addRecieveTransaction(transaction)
        CoreDataManager.shared.saveTransaction(transaction)
    }
}
